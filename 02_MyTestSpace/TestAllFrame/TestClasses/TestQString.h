/*!********************************************************
 *  @File        : TestQString.h
 *  @ClassName   : TestQChar TestQString
 *  @OS Env      : Linux/Unix&Windows
 *  @Brief       : briefs
 *  @Details     : details
 *  @Author      : taiga
 *  @Email       : taiga_tora@foxmail.com
 *  @Date        : 2024-04-26 12:42:11
 *  @Version     : v1.0
 *
 **********************************************************
 *
 *  @par modified log :
 *  @Attention        :
 *
 *********************************************************/

#ifndef TESTQSTRING_H
#define TESTQSTRING_H

//class TestQChar
class TestQChar
{
public:
    TestQChar();
    ~TestQChar() {}

    void test_QChar();
};

//class TestQString
class TestQString
{
public:
    TestQString();
    ~TestQString() {}

    void test01_QString_arg();
    void test02_QLatin1StringView_arg();
    void test03_QString_arg_double();
    void test04_QString_asprintf();
    void test05_QString_clear();
    void test06_QString_compare();
    void test07_fromLatin1();
    void test08_fromLocal8Bit();
    void test09_fromRawData();
    void test10_back_front();
    void test11_indexOf();
    void test12_insert();
    void test13_judgeIs();
    void test14_lastIndexOf();
    void test15_left_right();
    void test16_mid_sliced();
    void test17_remove();
    void test18_replace();
    void test19_reserve_resize();
    void test20_section();
    void test21_split();
    void test22_toALL();
    void test23_truncate_chop_capacity();
    void test24_fill();
    void test25_macro_QStringLiteral();
    void test26_macro_Printable();

    int run_test_function()
    {
        // test01_QString_arg();
        // test02_QLatin1StringView_arg();
        // test03_QString_arg_double();
        // test04_QString_asprintf();
        // test05_QString_clear();
        // test06_QString_compare();
        // test07_fromLatin1();
        // test08_fromLocal8Bit();
        // test09_fromRawData();
        // test10_back_front();
        // test11_indexOf();
        // test12_insert();
        // test13_judgeIs();
        // test14_lastIndexOf();
        // test15_left_right();
        // test16_mid_sliced();
        // test17_remove();
        // test18_replace();
        // test19_reserve_resize();
        // test20_section();
        // test21_split();
        // test22_toALL();
        // test23_truncate_chop_capacity();
        // test24_fill();
        // test25_macro_QStringLiteral();
        test26_macro_Printable();
        return 0;
    }
};
#endif // TESTQSTRING_H
