// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.




__kernel void reshape_mkt_to_nchw(const int ih_str, const int iw_str, const int ih_off, const int iw_off, const int ow_str, const int oh_str, 
    const int ow_off, const int oh_off, const int oh, const int bx, const int by, __global const T* in, __global T* out) {
    int idx = get_global_id(0);
    int idy = get_global_id(1);
    if(idx >= bx || idy >= by) return;
    T4 val;
    const int in_off = (idy * iw_str + iw_off) * ih_str + idx + ih_off;
    val = vload4(in_off, in);

    int  idk = (idy << 2);
    int  ox = idx;
    int4 oy;
    int4 oz;
    oy.s0 =  idk % oh;
    oy.s1 = (idk + 1) % oh;
    oy.s2 = (idk + 2) % oh;
    oy.s3 = (idk + 3) % oh;
    oz.s0 =  idk / oh;
    oz.s1 = (idk + 1) / oh;
    oz.s2 = (idk + 2) / oh;
    oz.s3 = (idk + 3) / oh;
    out[(oz.s0 * oh_str + oy.s0 + oh_off) * ow_str + ox + ow_off] = val.x;
    out[(oz.s1 * oh_str + oy.s1 + oh_off) * ow_str + ox + ow_off] = val.y;
    out[(oz.s2 * oh_str + oy.s2 + oh_off) * ow_str + ox + ow_off] = val.z;
    out[(oz.s3 * oh_str + oy.s3 + oh_off) * ow_str + ox + ow_off] = val.w;
}
