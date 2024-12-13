#!/usr/bin/env python
def test_ldc():
    import numpy as np
    from read_single_field_binary import read_single_field_binary
    data_1,xp_1,yp_1,zp_1,xu_1,yv_1,zw_1 = read_single_field_binary("data-oneStep/" ,"vey_fld_0001500.bin",np.array([1,1,1]))
    data_2,xp_2,yp_2,zp_2,xu_2,yv_2,zw_2 = read_single_field_binary("data-twoSteps/","vey_fld_0001500.bin",np.array([1,1,1]))
    islice = int(np.size(data_1[0,0,:])/2)
    np.testing.assert_allclose(data_1[0,islice,:], data_2[0,islice,:], rtol=1e-7, atol=0)
if __name__ == "__main__":
    test_ldc()
    print("Passed!")
