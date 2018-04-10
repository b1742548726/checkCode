package com.bk.wd.web.utils;

/**
 * 各进制相关处理工具
 * Created by wangweijun on 2018/03/05.
 */
public class HexUtils {

    /**
     * 用于判断两个值的二进制数是否相包含
     * 24 & 8 = 8
     * @param num1
     * @param num2
     * @return
     */
    public static boolean checkHexIntegerEq(Integer num1, Integer num2){
        return (num1 & num2) == num2;
    }

    public static boolean checkHexIntegerEqArr(Integer num1, Integer[] numArr){
        for (Integer n : numArr){
            if(checkHexIntegerEq(num1, n)){
                return true;
            }
        }
        return false;
    }

    public static void main(String args[]){
        System.out.println(HexUtils.checkHexIntegerEq(24, 8));
        System.out.println(HexUtils.checkHexIntegerEqArr(24, new Integer[]{8,16,32}));
    }
}
