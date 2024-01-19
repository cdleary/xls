// Copyright 2023 The XLS Authors
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

#include "xls/dslx/type_system/typecheck_test_helpers.h"

#include <string>
#include <string_view>
#include <utility>

#include "absl/status/statusor.h"
#include "xls/common/status/status_macros.h"
#include "xls/dslx/command_line_utils.h"
#include "xls/dslx/create_import_data.h"
#include "xls/dslx/parse_and_typecheck.h"
#include "xls/dslx/type_system/type_info_to_proto.h"

namespace xls::dslx {

absl::StatusOr<TypecheckedModule> Typecheck(std::string_view text) {
  auto import_data = CreateImportDataForTest();
  absl::StatusOr<TypecheckedModule> tm_or =
      ParseAndTypecheck(text, "fake.x", "fake", &import_data);
  if (!tm_or.ok()) {
    TryPrintError(tm_or.status(),
                  [&](std::string_view path) -> absl::StatusOr<std::string> {
                    return std::string(text);
                  });
    return tm_or.status();
  }
  TypecheckedModule& tm = tm_or.value();
  // Ensure that we can convert all the type information in the unit tests into
  // its protobuf form.
  XLS_RETURN_IF_ERROR(TypeInfoToProto(*tm.type_info).status());

  return std::move(tm);
}

}  // namespace xls::dslx
