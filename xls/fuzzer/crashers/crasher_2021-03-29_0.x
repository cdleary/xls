// Exception:
// Command '['/home/ubuntu/.cache/bazel/_bazel_ubuntu/72964951a7174037b401c715c5ae5229/execroot/com_google_xls/bazel-out/aarch64-opt/bin/xls/tools/eval_ir_main', '--input_file=args.txt', '--use_llvm_jit', 'sample.ir', '--logtostderr']' died with <Signals.SIGSEGV: 11>.
// Issue: DO NOT SUBMIT Insert link to GitHub issue here.
//
// options: {"codegen": true, "codegen_args": ["--use_system_verilog", "--generator=combinational"], "convert_to_ir": true, "input_is_dslx": true, "optimize_ir": true, "simulate": false, "simulator": null, "use_jit": true, "use_system_verilog": true}
// args: (bits[34]:0x2_aaaa_aaaa, bits[7]:0x1)
// args: (bits[34]:0x0, bits[7]:0x22)
// args: (bits[34]:0x3_ffff_ffff, bits[7]:0x48)
// args: (bits[34]:0x2_aaaa_aaaa, bits[7]:0x0)
const W5_V21 = u5:21;
type x1 = (s34, u7);
type x8 = (s34, u7);
type x12 = x1[2];
type x18 = bool;
type x25 = ((x12,), (x12,));
fn x22(x23: x12) -> ((x12,), (x12,)) {
  let x24: (x12,) = (x23,);
  (x24, x24)
}
fn main(x0: (s34, u7)) -> (x1[2], u21, s57, (s34, u7), x25[5], bool, bool) {
  let x2: x1[1] = [x0];
  let x3: x1[2] = (x2) ++ (x2);
  let x4: (x1[2], (s34, u7), x1[2]) = (x3, x0, x3);
  let x5: ((s34, u7), x1[2], (s34, u7), x1[1]) = (x0, x3, x0, x2);
  let x6: x1[3] = (x2) ++ (x3);
  let x7: x1[2] = (x4)[2];
  let x9: x8[1] = [x0];
  let x10: (x8[1], x1[2]) = (x9, x7);
  let x11: x8[2] = (x9) ++ (x9);
  let x13: x12[5] = [x3, x7, x3, x7, x3];
  let x14: s33 = s33:0x1_ffff_ffff;
  let x15: x8[1] = (x10)[0];
  let x16: u21 = (x14)[0+:u21];
  let x17: s33 = -(x14);
  let x19: x18[W5_V21] = ((x16) as x18[W5_V21]);
  let x20: u21 = -(x16);
  let x21: u13 = (x16)[0+:u13];
  let x26: x25[5] = map(x13, x22);
  let x27: u21 = clz(x16);
  let x28: s57 = s57:0x0;
  let x29: bool = (x16) > (x16);
  let x30: s57 = (x28) + (((x21) as s57));
  let x31: u21 = ctz(x27);
  let x32: u21 = bit_slice_update(x20, x31, x29);
  (x7, x31, x30, x0, x26, x29, x29)
}
