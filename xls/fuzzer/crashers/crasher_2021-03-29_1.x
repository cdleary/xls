// Exception:
// Command '['/home/ubuntu/.cache/bazel/_bazel_ubuntu/72964951a7174037b401c715c5ae5229/execroot/com_google_xls/bazel-out/aarch64-opt/bin/xls/tools/eval_ir_main', '--input_file=args.txt', '--use_llvm_jit', 'sample.ir', '--logtostderr']' died with <Signals.SIGSEGV: 11>.
// Issue: DO NOT SUBMIT Insert link to GitHub issue here.
//
// options: {"codegen": true, "codegen_args": ["--use_system_verilog", "--generator=pipeline", "--pipeline_stages=2"], "convert_to_ir": true, "input_is_dslx": true, "optimize_ir": true, "simulate": false, "simulator": null, "use_jit": true, "use_system_verilog": true}
// args: [(bits[4]:0xf, bits[28]:0x0, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0xd44), (bits[4]:0x0, bits[28]:0x7ff_ffff, bits[53]:0x15_5555_5555_5555, bits[12]:0x7ff), (bits[4]:0x5, bits[28]:0x7ff_ffff, bits[53]:0x15_5555_5555_5555, bits[12]:0x555), (bits[4]:0x8, bits[28]:0xfff_ffff, bits[53]:0xf_ffff_ffff_ffff, bits[12]:0x7ff), (bits[4]:0x7, bits[28]:0x7ff_ffff, bits[53]:0xf_ffff_ffff_ffff, bits[12]:0x0), (bits[4]:0xa, bits[28]:0x7ff_ffff, bits[53]:0x1f_ffff_ffff_ffff, bits[12]:0xe78), (bits[4]:0x5, bits[28]:0xfff_ffff, bits[53]:0x0, bits[12]:0x0), (bits[4]:0x7, bits[28]:0x800_0000, bits[53]:0x3_25b3_ae56_881e, bits[12]:0xfff), (bits[4]:0xa, bits[28]:0xfff_ffff, bits[53]:0x8000_0000, bits[12]:0xfff), (bits[4]:0x2, bits[28]:0xfff_ffff, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0x0), (bits[4]:0x2, bits[28]:0x400, bits[53]:0x0, bits[12]:0x0), (bits[4]:0x2, bits[28]:0x0, bits[53]:0x11_ba18_e315_2ef3, bits[12]:0x0)]
// args: [(bits[4]:0x5, bits[28]:0x7ff_ffff, bits[53]:0x15_5555_5555_5555, bits[12]:0xfff), (bits[4]:0x1, bits[28]:0xfff_ffff, bits[53]:0x20_0000, bits[12]:0x20), (bits[4]:0x0, bits[28]:0xaaa_aaaa, bits[53]:0x20, bits[12]:0x7d0), (bits[4]:0x0, bits[28]:0x7ff_ffff, bits[53]:0x0, bits[12]:0x0), (bits[4]:0xa, bits[28]:0xfff_ffff, bits[53]:0x6_58e3_fca1_fef7, bits[12]:0xb91), (bits[4]:0x0, bits[28]:0xaaa_aaaa, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0x7ff), (bits[4]:0x1, bits[28]:0x7ff_ffff, bits[53]:0x1f_ffff_ffff_ffff, bits[12]:0x7ff), (bits[4]:0x5, bits[28]:0x555_5555, bits[53]:0x1f_ffff_ffff_ffff, bits[12]:0x0), (bits[4]:0x4, bits[28]:0xfff_ffff, bits[53]:0xf_ffff_ffff_ffff, bits[12]:0x400), (bits[4]:0x0, bits[28]:0x555_5555, bits[53]:0xf_b81e_43f5_52fa, bits[12]:0x0), (bits[4]:0xf, bits[28]:0x555_5555, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0x7ff), (bits[4]:0x3, bits[28]:0x0, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0xfff)]
// args: [(bits[4]:0x0, bits[28]:0x100, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0x7ff), (bits[4]:0xf, bits[28]:0x621_ad93, bits[53]:0x15_5555_5555_5555, bits[12]:0xfff), (bits[4]:0x0, bits[28]:0x0, bits[53]:0x400_0000_0000, bits[12]:0x555), (bits[4]:0x5, bits[28]:0x2_0000, bits[53]:0x0, bits[12]:0xaaa), (bits[4]:0xf, bits[28]:0x112_d09e, bits[53]:0xf_ffff_ffff_ffff, bits[12]:0x0), (bits[4]:0x5, bits[28]:0xfff_ffff, bits[53]:0x17_066f_3e35_edd3, bits[12]:0x7ff), (bits[4]:0xa, bits[28]:0xfb6_08c0, bits[53]:0x100_0000, bits[12]:0x800), (bits[4]:0xa, bits[28]:0x555_5555, bits[53]:0x80, bits[12]:0x555), (bits[4]:0x0, bits[28]:0x7ff_ffff, bits[53]:0x1f_ffff_ffff_ffff, bits[12]:0x8), (bits[4]:0x5, bits[28]:0xaaa_aaaa, bits[53]:0x200_0000_0000, bits[12]:0x0), (bits[4]:0x8, bits[28]:0x7ff_ffff, bits[53]:0x0, bits[12]:0xaaa), (bits[4]:0x2, bits[28]:0x7ff_ffff, bits[53]:0x15_5555_5555_5555, bits[12]:0xaaa)]
// args: [(bits[4]:0xf, bits[28]:0x6d6_54e1, bits[53]:0xf_ffff_ffff_ffff, bits[12]:0x0), (bits[4]:0xa, bits[28]:0x40_0000, bits[53]:0x15_5555_5555_5555, bits[12]:0x0), (bits[4]:0x0, bits[28]:0xaaa_aaaa, bits[53]:0x15_5555_5555_5555, bits[12]:0x217), (bits[4]:0x4, bits[28]:0xccb_90d6, bits[53]:0x800_0000, bits[12]:0x555), (bits[4]:0x5, bits[28]:0x555_5555, bits[53]:0x0, bits[12]:0x0), (bits[4]:0x0, bits[28]:0x75d_9289, bits[53]:0x0, bits[12]:0x40), (bits[4]:0xa, bits[28]:0x100_0000, bits[53]:0x1_291e_0f3a_c530, bits[12]:0x555), (bits[4]:0xa, bits[28]:0xfff_ffff, bits[53]:0x1b_8239_28a8_69c3, bits[12]:0x20), (bits[4]:0x0, bits[28]:0x0, bits[53]:0x17_58cf_2034_4836, bits[12]:0xaaa), (bits[4]:0xf, bits[28]:0xfff_ffff, bits[53]:0x1e_d5fb_4243_ef29, bits[12]:0x7f9), (bits[4]:0x7, bits[28]:0xaaa_aaaa, bits[53]:0x1f_ffff_ffff_ffff, bits[12]:0x7ff), (bits[4]:0x8, bits[28]:0x10, bits[53]:0xa_aaaa_aaaa_aaaa, bits[12]:0x555)]
const W4_V12 = u4:12;
type x1 = (s4, u28, u53, u12);
type x6 = u49;
type x8 = x1[W4_V12];
type x17 = (s50, s50);
fn x2(x3: x1) -> u49 {
  let x4: u49 = u49:0xffff_ffff_ffff;
  let x5: u49 = -(x4);
  x5
}
fn x10(x11: x8) -> (s50, s50) {
  let x12: s50 = s50:0x1_5555_5555_5555;
  let x13: s50 = (x12) | (x12);
  let x14: s50 = (x12) | (x12);
  let x15: bool = bool:0x0;
  let x16: s50 = !(x14);
  (x13, x13)
}
fn main(x0: x1[W4_V12]) -> x1[W4_V12] {
  let x7: x6[W4_V12] = map(x0, x2);
  let x9: x8[1] = [x0];
  let x18: x17[1] = map(x9, x10);
  let x19: u16 = u16:0x7fff;
  let x20: bool = (x19) > (x19);
  let x21: bool = (x20) != (x20);
  let x22: bool = (x21) & (x21);
  let x23: bool = and_reduce(x22);
  let x24: u16 = one_hot_sel(x23, [x19]);
  let x25: u16 = (x19) << ((bool:false) if ((x23) >= (bool:false)) else (x23));
  let x26: u2 = (x19)[-2:];
  let x27: bool = xor_reduce(x20);
  let x28: bool = (x23)[0+:bool];
  let x29: (x6[W4_V12], bool, bool, bool, u16, u2) = (x7, x28, x22, x23, x25, x26);
  let x30: bool = bit_slice_update(x27, x23, x22);
  let x31: bool = (x29)[1];
  let x32: bool = (x22) << ((bool:false) if ((x28) >= (bool:false)) else (x28));
  let x33: bool = (x32)[x27+:bool];
  let x34: bool = (x27) >> ((bool:false) if ((x21) >= (bool:false)) else (x21));
  let x35: bool = (x30) + (((x26) as bool));
  let x36: bool = (x21)[0+:bool];
  let x37: u2 = -(x26);
  let x38: s36 = s36:0xa_aaaa_aaaa;
  let x39: u6 = (((((x36) ++ (x30)) ++ (x27)) ++ (x27)) ++ (x31)) ++ (x32);
  x0
}
