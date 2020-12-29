// Copyright 2020 The XLS Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "absl/base/casts.h"
#include "absl/status/statusor.h"
#include "absl/strings/ascii.h"
#include "pybind11/functional.h"
#include "pybind11/pybind11.h"
#include "pybind11/stl.h"
#include "xls/common/status/status_macros.h"
#include "xls/common/status/statusor_pybind_caster.h"
#include "xls/dslx/concrete_type.h"
#include "xls/dslx/deduce.h"
#include "xls/dslx/ir_converter.h"
#include "xls/dslx/python/cpp_ast.h"
#include "xls/dslx/python/errors.h"
#include "xls/ir/python/wrapper_types.h"

namespace py = pybind11;

namespace xls::dslx {
namespace {

using IrValue = IrConverter::IrValue;
using CValue = IrConverter::CValue;

// Wraps a BValue into a (pybind convertible) BValueHolder type.
BValueHolder Wrap(IrConverter& self, const BValue& value) {
  return BValueHolder(value, self.package(), self.function_builder());
}

}  // namespace

PYBIND11_MODULE(cpp_ir_converter, m) {
  ImportStatusModule();
  py::module::import("xls.ir.python.package");
  py::module::import("xls.ir.python.function_builder");
  py::module::import("xls.dslx.python.cpp_ast");

  py::class_<IrConverter>(m, "IrConverter")
      .def(py::init([](PackageHolder package, ModuleHolder module,
                       const std::shared_ptr<TypeInfo>& type_info,
                       bool emit_positions) {
        return absl::make_unique<IrConverter>(
            package.package(), &module.deref(), type_info, emit_positions);
      }))
      .def("instantiate_function_builder",
           &IrConverter::InstantiateFunctionBuilder)
      .def_property_readonly("fileno", &IrConverter::fileno)
      .def_property_readonly("package",
                             [](IrConverter& self) {
                               return PackageHolder(self.package().get(),
                                                    self.package());
                             })
      .def_property_readonly("module",
                             [](IrConverter& self) {
                               return ModuleHolder(
                                   self.module(),
                                   self.module()->shared_from_this());
                             })
      .def_property_readonly("type_info",
                             [](IrConverter& self) { return self.type_info(); })
      .def_property_readonly(
          "function_builder",
          [](IrConverter& self) -> absl::optional<FunctionBuilderHolder> {
            if (self.function_builder() == nullptr) {
              return absl::nullopt;
            }
            return FunctionBuilderHolder(self.package(),
                                         self.function_builder());
          })
      .def_property_readonly("emit_positions", &IrConverter::emit_positions)
      .def_property_readonly(
          "constant_deps",
          [](IrConverter& self) {
            py::tuple result(self.constant_deps().size());
            for (int64 i = 0; i < self.constant_deps().size(); ++i) {
              result[i] = ConstantDefHolder(self.constant_deps()[i],
                                            self.module()->shared_from_this());
            }
            return result;
          })
      .def("clear_constant_deps",
           [](IrConverter& self) { self.ClearConstantDeps(); })
      .def_property(
          "last_expression",
          [](IrConverter& self) -> absl::optional<ExprHolder> {
            if (self.last_expression() == nullptr) {
              return absl::nullopt;
            }
            return ExprHolder(
                self.last_expression(),
                self.last_expression()->owner()->shared_from_this());
          },
          [](IrConverter& self, ExprHolder expr) {
            self.set_last_expression(&expr.deref());
          })
      .def("set_node_to_ir",
           [](IrConverter& self, AstNodeHolder node, BValueHolder value) {
             self.SetNodeToIr(&node.deref(), value.deref());
           })
      .def("set_node_to_ir",
           [](IrConverter& self, AstNodeHolder node,
              std::pair<Bits, BValueHolder> value) {
             self.SetNodeToIr(
                 &node.deref(),
                 IrConverter::CValue{value.first, value.second.deref()});
           })
      .def("get_node_to_ir",
           [](IrConverter& self, AstNodeHolder node)
               -> absl::optional<
                   absl::variant<BValueHolder, std::pair<Bits, BValueHolder>>> {
             absl::optional<IrValue> value = self.GetNodeToIr(&node.deref());
             if (!value.has_value()) {
               return absl::nullopt;
             }
             if (absl::holds_alternative<BValue>(*value)) {
               return Wrap(self, absl::get<BValue>(*value));
             }
             const CValue& cvalue = absl::get<CValue>(*value);
             return std::make_pair(cvalue.integral, Wrap(self, cvalue.value));
           })
      .def("add_constant_dep",
           [](IrConverter& self, ConstantDefHolder constant_def) {
             self.AddConstantDep(&constant_def.deref());
           })
      .def("def_alias",
           [](IrConverter& self, AstNodeHolder from,
              AstNodeHolder to) -> absl::StatusOr<BValueHolder> {
             XLS_ASSIGN_OR_RETURN(BValue value,
                                  self.DefAlias(&from.deref(), &to.deref()));
             return Wrap(self, value);
           })
      .def("use",
           [](IrConverter& self,
              AstNodeHolder node) -> absl::StatusOr<BValueHolder> {
             XLS_ASSIGN_OR_RETURN(BValue value, self.Use(&node.deref()));
             return Wrap(self, value);
           })
      .def("set_symbolic_bindings",
           [](IrConverter& self, absl::optional<SymbolicBindings> value) {
             if (value) {
               self.set_symbolic_binding_map(value->ToMap());
             } else {
               self.clear_symbolic_binding_map();
             }
           })
      .def("get_symbolic_binding",
           [](const IrConverter& self, absl::string_view identifier) {
             absl::optional<int64> result =
                 self.get_symbolic_binding(identifier);
             if (result) {
               return *result;
             }
             throw py::key_error(
                 absl::StrCat("Symbolic binding not found for: ", identifier));
           })
      .def("get_symbolic_bindings",
           [](const IrConverter& self) { return self.GetSymbolicBindings(); })
      .def("set_symbolic_binding",
           [](IrConverter& self, std::string identifier, int64 value) {
             self.set_symbolic_binding(std::move(identifier), value);
           })
      .def("get_symbolic_bindings_items",
           [](IrConverter& self) {
             py::tuple result(self.symbolic_binding_map().size());
             int64 i = 0;
             for (auto& item : self.symbolic_binding_map()) {
               result[i++] = std::make_pair(item.first, item.second);
             }
             return result;
           })
      .def("get_and_bump_counted_for_count",
           &IrConverter::GetAndBumpCountedForCount)
      .def("get_const_bits",
           [](IrConverter& self, AstNodeHolder node) {
             return self.GetConstBits(&node.deref());
           })
      .def("resolve_dim", &IrConverter::ResolveDim)
      .def("resolve_type",
           [](IrConverter& self, AstNodeHolder node) {
             return self.ResolveType(&node.deref());
           })
      .def("handle_attr",
           [](IrConverter& self, AttrHolder node) {
             return self.HandleAttr(&node.deref());
           })
      .def("handle_binop",
           [](IrConverter& self, BinopHolder node) {
             return self.HandleBinop(&node.deref());
           })
      .def("handle_ternary",
           [](IrConverter& self, TernaryHolder node) {
             return self.HandleTernary(&node.deref());
           })
      .def("handle_constant_array",
           [](IrConverter& self, ConstantArrayHolder node) {
             return self.HandleConstantArray(&node.deref());
           })
      .def("handle_unop", [](IrConverter& self, UnopHolder node) {
        return self.HandleUnop(&node.deref());
      });

  m.def("mangle_dslx_name",
        [](absl::string_view function_name,
           const std::set<std::string>& free_keys, ModuleHolder m,
           absl::optional<SymbolicBindings> symbolic_bindings) {
          return MangleDslxName(
              function_name,
              absl::btree_set<std::string>(free_keys.begin(), free_keys.end()),
              &m.deref(),
              symbolic_bindings.has_value() && !symbolic_bindings->empty()
                  ? &*symbolic_bindings
                  : nullptr);
        });
}

}  // namespace xls::dslx
