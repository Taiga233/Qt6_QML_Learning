/*!********************************************************
 *  @File        : TestQString.cpp
 *  @ClassName   : TestQChar TestQString
 *  @OS Env      : Linux/Unix&Windows
 *  @Brief       : briefs
 *  @Details     : details
 *  @Author      : taiga
 *  @Email       : taiga_tora@foxmail.com
 *  @Date        : 2024-04-26 12:41:23
 *  @Version     : v1.0
 *
 **********************************************************
 *
 *  @par modified log :
 *  @Attention        :
 *
 *********************************************************/

#include "TestQString.h"

#include <QDebug>
#include <QChar>
#include <QString>
#include <QLatin1StringView>
#include <QLatin1String>
#include <QStringView>
#include <QStringLiteral>
#include <QTextStream>
#include <QRegularExpression>

////class TestQChar
TestQChar::TestQChar() {}

void TestQChar::test_QChar()
{
    QString str_t("你好世界");
    Q_UNUSED(str_t)
    QChar char1_t = QString("中").at(0);
    QChar char2_t = QString("国").at(0);
    qDebug() << "字符 中 的Unicode编码值(hex)：" << Qt::hex << Qt::showbase << char1_t.unicode();
    qDebug() << "字符 国 的Unicode编码值(hex)：" << Qt::hex << Qt::showbase << char2_t.unicode();
}


////class TestQString
TestQString::TestQString() {}

void TestQString::test01_QString_arg()
{
    QString result_QS_t;
    QString padded_QS_t("lie");
    QChar fillChar_QC_t = u'e';
    qDebug() << "1:" << QString("be%1%2").arg("lie").arg("ve");
    qDebug() << "2:"  << QString("be%1").arg("lie").arg("ve");
    qDebug() << "3:"  << QString("be%2").arg("lie").arg("ve");

    //result_QS_t结果："believe"
    result_QS_t = QString("be%1%2").arg(padded_QS_t).arg("ve");
    qDebug() << "4:" << result_QS_t;

    //result_QS_t结果："belieeeevvvve"
    result_QS_t = QString("be%1%2").arg(padded_QS_t, -6, fillChar_QC_t).arg("ve", 5u, QChar::fromLatin1('v'));
    qDebug() << "5:" << result_QS_t;

    //result_QS_t结果："belielielieve"
    result_QS_t = QString("be%2%2%2%1").arg("ve").arg(padded_QS_t);
    qDebug() << "6:" << result_QS_t;
}

void TestQString::test02_QLatin1StringView_arg()
{
    QString result_QS_t;
    QLatin1StringView latin1StringView_QLSV_t("lie");
    //result_QS_t结果："believe"
    // result_QS_t = QString("be%1%2%3").arg(padded_QS_t, QChar('v'), "e"_L1);//为什么_L1无用？
    result_QS_t = QString("be%1%2%3%4").arg(latin1StringView_QLSV_t, QChar('v'), QLatin1StringView("e"), QStringLiteral("：相信"));
    qDebug() << "7:" << result_QS_t;
}

void TestQString::test03_QString_arg_double()
{
    double PI_d_t = 31415926.535897932384626;
    QString str_QS_t = QString(QStringLiteral("π：%1")).arg(PI_d_t, 0, 'e', 4);
    qDebug() << "8:" << str_QS_t;
    //结果："π：3.1416e+07"
}

void TestQString::test04_QString_asprintf()
{
    QString strReplaced_QS_t("世界");
    QString strResult_QS_t(QString::asprintf("Hello, World.(你好，%s。)", "世界")); //错误的，这样写跟源程序代码编码有关，如果源文件编码为UTF-8则能显示否则显示乱码
    qDebug() << "1:" << strResult_QS_t;
    strResult_QS_t = QString::asprintf("Hello, World.(你好，%s。)", strReplaced_QS_t.toLocal8Bit().data()); //错误的，会得到乱码
    qDebug() << "2:" << strResult_QS_t;
    strResult_QS_t = QString::asprintf("Hello, World.(你好，%s。)", strReplaced_QS_t.data()); //错误的，会得到乱码
    qDebug() << "3:" << strResult_QS_t;

    strResult_QS_t = QString::asprintf("hello, world %.10f", 3.1415); //正确的，结果为"hello, world 3.1415000000"
    qDebug() << "4:" << strResult_QS_t;
}

void TestQString::test05_QString_clear()
{
    QString str_QS_t = "hello";
    str_QS_t.clear();
    qDebug() << "1: clear QString, isNull:" << str_QS_t.isNull() << " isEmpty:" << str_QS_t.isEmpty();
}

void TestQString::test06_QString_compare()
{
    int result1_i_t = QString::compare("auto", "Car", Qt::CaseSensitive);
    int result2_i_t = QString::compare("auto", "Car", Qt::CaseInsensitive);
    qDebug() << "1:" << result1_i_t << "2:" << result2_i_t;
    qDebug() << "unicode('a')" /*<< Qt::hex << Qt::showbase*/ << (int)QChar('a').unicode() << "unicode('C')" << (int)QChar('C').unicode();
}

void TestQString::test07_fromLatin1()
{
    QString str1_QS_t;
    str1_QS_t = QString::fromLatin1("test string", 3);
    qDebug() << "1:" << str1_QS_t;
    str1_QS_t.clear();
    str1_QS_t = QString::fromLatin1("test string", -5);
    qDebug() << "2:" << str1_QS_t;
    str1_QS_t.clear();
    str1_QS_t = QString::fromLatin1("test string", -1);
    qDebug() << "3:" << str1_QS_t;
    str1_QS_t.clear();
    str1_QS_t = QString::fromLatin1("test string");
    qDebug() << "4:" << str1_QS_t << "size:" << str1_QS_t.size();
    str1_QS_t.clear();
    str1_QS_t = QString::fromLatin1("test string", 100);
    qDebug() << "5:" << str1_QS_t << "size:" << str1_QS_t.size() << "capacity:" << str1_QS_t.capacity();
    for (auto i = str1_QS_t.constBegin(); i != str1_QS_t.constEnd(); ++i) {
        qDebug() << i->unicode();
    }
    str1_QS_t.clear();
    str1_QS_t = QString::fromLatin1("test string", 0);
    qDebug() << "6:" << str1_QS_t << "size:" << str1_QS_t.size() << "capacity:" << str1_QS_t.capacity();
}

void TestQString::test08_fromLocal8Bit()
{
    QString str1_QS_t;
    str1_QS_t = QString::fromLocal8Bit("test string", 5);
    qDebug() << "1:" << str1_QS_t;
    str1_QS_t.clear();
    str1_QS_t = QString::fromLocal8Bit("test你好", 6);
    qDebug() << "2:" << str1_QS_t;
    str1_QS_t.clear();

    //测试如果源数据被删除
    QString str2_QS_t;
    {
        char sourceData_c_At[2]{'Q', 't'};
        str2_QS_t = QString::fromLocal8Bit(sourceData_c_At, sizeof(sourceData_c_At) / sizeof(char));
        qDebug() << "3 stack internal:" << str2_QS_t << str2_QS_t.size();
    }
    qDebug() << "4 external:" << str2_QS_t << str2_QS_t.size();
}

void TestQString::test09_fromRawData()
{
    QString str1_QS_t;
    //QT6以上不再支持隐式转换
    QChar unicode_QC_t[] = {
        (QChar)0x0071u, (QChar)0x0074u, (QChar)0x0020u,
        (QChar)0x0066u, (QChar)0x006fu, (QChar)0x0072u,
        (QChar)0x0020u, (QChar)0x0065u, (QChar)0x0076u,
        (QChar)0x0065u, (QChar)0x0072u, (QChar)0x0079u,
        (QChar)0x0074u, (QChar)0x0068u, (QChar)0x0069u,
        (QChar)0x006eu, (QChar)0x0067u
    };
    qsizetype size_qst_t = sizeof(unicode_QC_t) / sizeof(QChar);
    str1_QS_t = QString::fromRawData(unicode_QC_t, size_qst_t); //str1_QS_t === "qt for everything"
    qDebug() << "1:" << str1_QS_t;
    static QRegularExpression pattern_QRE_s("\u0020");
    if (str1_QS_t.contains(pattern_QRE_s)) {
        qDebug() << "matched";
    }
    // str1_QS_t.clear();
    //如果在这里修改了原始数据的内容，则不能保证QString更改，这样做危险！
    unicode_QC_t[3] = 's', unicode_QC_t[4] = 'e', unicode_QC_t[5] = 't';
    //str1_QS_t === "qt set everything"
    qDebug() << "2:" << str1_QS_t;
    QChar *unicode_QC_Pt = unicode_QC_t;
    QString str2_QS_t = QString::fromRawData(unicode_QC_Pt, 17);
    qDebug() << "3 before deleted:" << str2_QS_t;
    unicode_QC_Pt = Q_NULLPTR;
    qDebug() << "4 after deleted:" << str2_QS_t;
    unicode_QC_Pt = new QChar[2];
    unicode_QC_Pt[0] = (QChar)0x0071u, unicode_QC_Pt[1] = (QChar)0x0074u;
    str2_QS_t = QString::fromRawData(unicode_QC_Pt, 2);
    qDebug() << "5 before deleted:" << str2_QS_t;
    delete[] unicode_QC_Pt;
    unicode_QC_Pt = Q_NULLPTR;
    qDebug() << "6 after deleted:" << str2_QS_t;

    // QString str2_QS_t{"qt for everything"};
    // foreach (const auto i, str2_QS_t) {
    //     qDebug() << Qt::hex << Qt::showbase << (ushort)i.unicode();
    // }

    QString str3_QS_t{"qt for everything"};
    QTextStream stream_QTS_t(stdout);
    auto returnUnicodeStream = [&] (const QString &str)mutable -> int {
        uint count_t = 0;
        foreach (const auto i, str) {
            stream_QTS_t << Qt::hex << Qt::showbase <<(ushort)i.unicode() << " ";
            count_t++;
        }
        stream_QTS_t.flush();
        Qt::endl(stream_QTS_t);
        return count_t;
    };
    Qt::endl(stream_QTS_t);
    qDebug() << "stream width:" << returnUnicodeStream(str3_QS_t) << "detail:";
}

void TestQString::test10_back_front()
{
    QString str1_QS_t("peak");
    str1_QS_t.front() = 'b';
    qDebug() << "k(unicode):" << Qt::hex << Qt::showbase << (ushort)QChar('k').unicode();
    qDebug() << "t(unicode):" << Qt::hex << Qt::showbase << (ushort)QChar('t').unicode();
    str1_QS_t.back().setCell(0x74u);
    qDebug() << "after modified:" << str1_QS_t; //"beat"
}

void TestQString::test11_indexOf()
{
    QString str1_QS_t("Reference by Taiga");
    QString str2_QS_t("re");
    qsizetype index_qst_t = str1_QS_t.indexOf(str2_QS_t); //4
    qDebug() << "1:" << index_qst_t;
    index_qst_t = str1_QS_t.indexOf("Re", 1, Qt::CaseInsensitive); //4
    qDebug() << "2:" << index_qst_t;
    index_qst_t = str1_QS_t.indexOf("ga", -1); //-1
    qDebug() << "3:" << index_qst_t;
    index_qst_t = str1_QS_t.indexOf("ga", -2); //16
    qDebug() << "4:" << index_qst_t;
    index_qst_t = str1_QS_t.indexOf(QChar('a'), -5); //14
    qDebug() << "5:" << index_qst_t;

    QRegularExpressionMatch match_QREM_pt;
    static QRegularExpression expression_QRE_s("[aeiou]+");
    //index_qst_t:14    //match_QREM_pt.captured():"ai"
    index_qst_t = str1_QS_t.indexOf(expression_QRE_s, -5, &match_QREM_pt);
    qDebug() << "6:" << index_qst_t << match_QREM_pt.captured();
    expression_QRE_s.setPattern("e[^aeiou]");
    index_qst_t = str1_QS_t.indexOf(expression_QRE_s); //1
    qDebug() << "7:" << index_qst_t;
}

void TestQString::test12_insert()
{
    QString str1_QS_t("Qt");
    str1_QS_t.insert(4, QString("Everything")); //str1_QS_t == "Qt  Everything"
    qDebug() << "1:" << str1_QS_t;
    str1_QS_t.insert(2, QString("For")); //str1_QS_t == "QtFor  Everything"
    qDebug() << "2:" << str1_QS_t;
}

void TestQString::test13_judgeIs()
{
    //https://www.unicode.org/reports/tr9/tr9-35.html#Table_Bidirectional_Character_Types
    QString str1_QS_t("gnihtyreve rof tQ"); //false
    QString str2_QS_t("界世，好你"); //false
    qDebug() << "1:" << str1_QS_t.isRightToLeft() << "2:" << str2_QS_t.isRightToLeft();
}

void TestQString::test14_lastIndexOf()
{
    QString str1_QS_t("Reference by Taiga");
    qDebug() << "str1_QS_t.size():" << str1_QS_t.size();
    qsizetype index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf("AI", Qt::CaseInsensitive); //14
    qDebug() << "1:" << index_qst_t;

    index_qst_t = str1_QS_t.lastIndexOf(QString("e")); //8
    qDebug() << "2:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString("e"), 0); //-1
    qDebug() << "3:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString("e"), -1); //8
    qDebug() << "4:" << index_qst_t;

    index_qst_t = str1_QS_t.lastIndexOf(QString("re"), 4); //4
    qDebug() << "5:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString("re"), 5); //4
    qDebug() << "6:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString("re"), 3, Qt::CaseInsensitive); //0
    qDebug() << "7:" << index_qst_t;

    index_qst_t = str1_QS_t.lastIndexOf(QString("")); //18
    qDebug() << "8:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString(""), -1); //17
    qDebug() << "9:" << index_qst_t;
    index_qst_t = str1_QS_t.lastIndexOf(QString(""), 0); //0
    qDebug() << "10:" << index_qst_t;

    static QRegularExpression expression_QRE_s("[eiou](g)?");
    QRegularExpressionMatch match_QREM_pt;
    index_qst_t = str1_QS_t.lastIndexOf(expression_QRE_s, &match_QREM_pt); //15 "ig"
    qDebug() << "11:" << index_qst_t << match_QREM_pt.captured();
    index_qst_t = str1_QS_t.lastIndexOf(expression_QRE_s, -3, &match_QREM_pt); //15 "ig"
    qDebug() << "12:" << index_qst_t << match_QREM_pt.captured();
    index_qst_t = str1_QS_t.lastIndexOf(expression_QRE_s, -4, &match_QREM_pt); //8 "e"
    qDebug() << "13:" << index_qst_t << match_QREM_pt.captured();
}

void TestQString::test15_left_right()
{
    QString str1_QS_t("Qt For Everything");
    qDebug() << "1:" << str1_QS_t.leftJustified(20, L'.');
    qDebug() << "2:" << str1_QS_t.leftJustified(20, L'.', true);
    qDebug() << "3:" << str1_QS_t.leftJustified(6, L'.', true);
    qDebug() << "4:" << str1_QS_t.leftJustified(6, L'.', false);
    qDebug() << "5:" << str1_QS_t.leftJustified(-2, L'.', true);
    qDebug() << "6:" << str1_QS_t.leftJustified(-2, L'.', false);
}

void TestQString::test16_mid_sliced()
{
    QString str1_QS_t("Qt For Everything");
    qDebug() << "1:" << str1_QS_t.mid(-4);
    qDebug() << "2:" << str1_QS_t.mid(-4, 2);
    qDebug() << "3:" << str1_QS_t.sliced(-4);
    qDebug() << "4:" << str1_QS_t.sliced(-4, 2);
    qDebug() << "5:" << str1_QS_t.sliced(2, 3);
    qDebug() << "6:" << str1_QS_t.sliced(2, -3);
    qDebug() << "6:" << str1_QS_t.sliced(2, 30);
}

void TestQString::test17_remove()
{
    QString str1_QS_t("Qt For Everything");
    str1_QS_t.remove(-1, 2);
    qDebug() << "1:" << str1_QS_t;
    str1_QS_t.remove(-7, 2);
    qDebug() << "2:" << str1_QS_t;
    str1_QS_t.remove(-7, -2);
    qDebug() << "3:" << str1_QS_t;
}

void TestQString::test18_replace()
{
    QString str1_QS_t("Qt For Everything");
    str1_QS_t.replace(-3, 2, QString("xx")); //"Qt For Everything"
    qDebug() << "1(nagative position):" << str1_QS_t;
    str1_QS_t.replace(3, 0, QString("xx")); //"Qt xxFor Everything"
    qDebug() << "2(no length to replace):" << str1_QS_t;
    str1_QS_t.replace(2, -2, QString("?")); //"Qt?Qt xxFor Everything"
    qDebug() << "3(nagative length):" << str1_QS_t;

    QString str2_QS_t("ReReereee");
    str2_QS_t.replace(QString("re"), QChar('r'), Qt::CaseInsensitive); //"rreree"
    qDebug() << "4(whether rescanned):" << str2_QS_t;
    str2_QS_t.replace(QChar('r'), QChar('r'), Qt::CaseInsensitive); //"rreree"
    qDebug() << "5(whether rescanned):" << str2_QS_t;


    QString str3_QS_t("Qt qt qqt qqttqq");
    QChar before_QC_ta[] = {'q', 't'};
    QChar after_QC_ta[] = {'C', '+', '+'};
    //"C++t C++t C++C++t C++C++ttC++C++"
    str3_QS_t.replace(before_QC_ta, 1, after_QC_ta, 3, Qt::CaseInsensitive);
    qDebug() << "6(before-length less than before size):" << str3_QS_t;
    str3_QS_t = "Qt qt qqt qqttqq";
    //"C++ C++ qC++ qC++tqq"
    str3_QS_t.replace(before_QC_ta, 2, after_QC_ta, 3, Qt::CaseInsensitive);
    qDebug() << "7(before-length equal before size):" << str3_QS_t;
    str3_QS_t = "Qt qt qqt qqttqq";
    //"Qt qt qqt qqttqq"
    str3_QS_t.replace(before_QC_ta, 3, after_QC_ta, 3, Qt::CaseInsensitive);
    qDebug() << "8(before-length greater than before size):" << str3_QS_t;
    str3_QS_t = "Qt qt qqt qqttqq";
    //"C+ C+ qC+ qC+tqq"
    str3_QS_t.replace(before_QC_ta, 2, after_QC_ta, 2, Qt::CaseInsensitive);
    qDebug() << "9(after-length less than after size):" << str3_QS_t;
    str3_QS_t = "Qt qt qqt qqttqq";
    //"C++\u0000 C++\u0000 qC++\u0000 qC++\u0000tqq"
    str3_QS_t.replace(before_QC_ta, 2, after_QC_ta, 4, Qt::CaseInsensitive);
    qDebug() << "10(after-length greater than after size):" << str3_QS_t;

    QString str4_QS_t("Qt qt qqt qqttqq");
    static QRegularExpression express_QRE_s("([^Q ]*)([t]+)([q]?)");
    //"Q() (q) (qq) (qqt)q"
    str4_QS_t.replace(express_QRE_s, QString("(\\1)"));
    qDebug() << "11:" << str4_QS_t;
    str4_QS_t = "Qt qt qqt qqttqq";
    //"Q(t) (t) (t) (t)q"
    str4_QS_t.replace(express_QRE_s, QString("(\\2)"));
    qDebug() << "12:" << str4_QS_t;
    str4_QS_t = "Qt qt qqt qqttqq";
    //"Q() () () (q)q"
    str4_QS_t.replace(express_QRE_s, QString("(\\3)"));
    qDebug() << "13:" << str4_QS_t;
    str4_QS_t = "Qt qt qqt qqttqq";
    //"Q(\\4) (\\4) (\\4) (\\4)q"
    str4_QS_t.replace(express_QRE_s, QString("(\\4)"));
    qDebug() << "14:" << str4_QS_t;
    str4_QS_t = "Qt qt qqt qqttqq";
    //"Q(t\\4) (qt\\4) (qqt\\4) (qqttq\\4)q"
    str4_QS_t.replace(express_QRE_s, QString("(\\1\\2\\3\\4)"));
    qDebug() << "15:" << str4_QS_t;
}

void TestQString::test19_reserve_resize()
{
    QString str1_QS_t;
    //reserve
    str1_QS_t.reserve(17); //17
    str1_QS_t.push_back("Qt");
    qDebug() << "1:" << str1_QS_t.size() << str1_QS_t.capacity();
    str1_QS_t.reserve(7); //17
    qDebug() << "2:" << str1_QS_t.capacity();
    str1_QS_t.reserve(20); //20
    qDebug() << "3:" << str1_QS_t.capacity();
    str1_QS_t.clear(); //0
    qDebug() << "4:" << str1_QS_t.capacity();
    str1_QS_t.reserve(5); //5
    qDebug() << "5:" << str1_QS_t.capacity();
    str1_QS_t = ""; //5
    qDebug() << "6:" << str1_QS_t.capacity();
    str1_QS_t.reserve(3); //5
    qDebug() << "7:" << str1_QS_t.capacity();

    str1_QS_t = "Qt For Everything";
    str1_QS_t.reserve(5); //17
    qDebug() << "8:" << str1_QS_t.size() << str1_QS_t.capacity();

    //resize
    str1_QS_t.resize(-3);
    qDebug() << "9: " << str1_QS_t.isEmpty() << str1_QS_t.isNull();
    QString str2_QS_t;
    str2_QS_t = "Qt";
    str2_QS_t = str2_QS_t.leftJustified(10, u'Q'); //"QtQQQQQQQQ"
    qDebug() << "10:" << str2_QS_t;
    str2_QS_t = "Qt";
    str2_QS_t.resize(10, u'T'); //"QtTTTTTTTT"
    qDebug() << "11:" << str2_QS_t;
}

void TestQString::test20_section()
{
    QString str1_QS_t(",Qt,,for,everything,"), str2_QS_t{}, str3_QS_t("Re f erEnce");
    str2_QS_t = str1_QS_t.section(QChar(), 1); //""
    qDebug() << "1: " << str2_QS_t;
    str2_QS_t = str1_QS_t.section(",", -2, -1); //"everything,"
    qDebug() << "2: " << str2_QS_t;
    str2_QS_t = str1_QS_t.section(",", -1, -2); //""
    qDebug() << "3: " << str2_QS_t;

    str2_QS_t = str3_QS_t.section("e", -3, -2); //" f erEnc"
    qDebug() << "4: " << str2_QS_t;
    str2_QS_t = str3_QS_t.section("e", -3, -2, QString::SectionSkipEmpty); //"Re f "
    qDebug() << "5: " << str2_QS_t;
    str2_QS_t = str1_QS_t.section(",", -3, -2, QString::SectionIncludeLeadingSep); //",for,everything"
    qDebug() << "6: " << str2_QS_t;
    str2_QS_t = str1_QS_t.section(",", -3, -2, QString::SectionIncludeTrailingSep); //"for,everything,"
    qDebug() << "7: " << str2_QS_t;
    str2_QS_t = str3_QS_t.section("e", -3, -2, QString::SectionCaseInsensitiveSeps); //"renc"
    qDebug() << "8: " << str2_QS_t;
    str2_QS_t = str3_QS_t.section("e", -3, -2, QString::SectionCaseInsensitiveSeps | QString::SectionSkipEmpty); //" f er"
    qDebug() << "9: " << str2_QS_t;
}

void TestQString::test21_split()
{
    QString str1_QS_t("qt for,everything reference,");
    QString str2_QS_t("Q t");
    QStringList result_QSL_t;
    result_QSL_t = str1_QS_t.split(";"); //["qt for,everything reference,"]
    qDebug() << "1:" << result_QSL_t;
    result_QSL_t = str1_QS_t.split(","); //["qt for", "everything reference", ""]
    qDebug() << "2:" << result_QSL_t;
    result_QSL_t = str1_QS_t.split(",", Qt::SkipEmptyParts); //["qt for", "everything reference"]
    qDebug() << "3:" << result_QSL_t;
    result_QSL_t = str2_QS_t.split(QString(), Qt::KeepEmptyParts); //["", "Q", " ", "t", ""]
    qDebug() << "4:" << result_QSL_t;
    result_QSL_t = str2_QS_t.split(QString(), Qt::SkipEmptyParts); //["Q", " ", "t"]
    qDebug() << "5:" << result_QSL_t;
    const QRegularExpression expr_QRE_c("\\b[^a-z^A-Z]");
    result_QSL_t = str1_QS_t.split(expr_QRE_c, Qt::SkipEmptyParts); //["qt", "for", "everything", "reference"]
    qDebug() << "6:" << result_QSL_t;
}

void TestQString::test22_toALL()
{
    QString str1_QS_t("qT FOr evErYthIng");
    QString result;
    str1_QS_t = "qt for everything";
    result = str1_QS_t.toCaseFolded();
    qDebug() << "1:" << result;

    QString str2_QS_t(" 7654 ");
    int toInt_i_t = str2_QS_t.toInt();
    qDebug() << "2:" << toInt_i_t;
    toInt_i_t = str2_QS_t.toInt(Q_NULLPTR, 8);
    qDebug() << "3:" << toInt_i_t;
}

void TestQString::test23_truncate_chop_capacity()
{
    QString str1_QS_t("qt for everything");
    QString str2_QS_t("qt for everything");
    str1_QS_t.chop(5); //"qt for every" size: 12 capacity: 17
    qDebug() << "1(chop):" << str1_QS_t << "size:" << str1_QS_t.size() << "capacity:" << str1_QS_t.capacity();
    str2_QS_t.truncate(5); //"qt fo" size: 5 capacity: 17
    qDebug() << "2(truncate):" << str2_QS_t << "size:" << str2_QS_t.size() << "capacity:" << str2_QS_t.capacity();
    str2_QS_t.truncate(-5); //"" size: 0 capacity: 17
    qDebug() << "3(truncate):" << str2_QS_t << "size:" << str2_QS_t.size() << "capacity:" << str2_QS_t.capacity();
}

void TestQString::test24_fill()
{
    QString str1_QS = "four";
    str1_QS.fill(QChar('a'));
    qDebug() << "1:" << str1_QS;
    str1_QS.clear();
    str1_QS.fill(QChar('b'));
    qDebug() << "2:" << str1_QS;
    str1_QS.clear();
    str1_QS.fill(QChar('c'), -3);
    qDebug() << "3:" << str1_QS;
    str1_QS = "four";
    str1_QS.fill(QChar('d'), -3);
    qDebug() << "4:" << str1_QS;
}

void TestQString::test25_macro_QStringLiteral()
{
    QString str1 = QStringLiteral(u"xxxxxxx"); //str1: "xxxxxxx" size: 7 capacity: 0
    QString str2 = QStringLiteral("xxxxxxxx"); //str2: "xxxxxxxx" size: 8 capacity: 0
    qDebug() << "str1:" << str1 << "size:" << str1.size() << "capacity:" << str1.capacity();
    qDebug() << "str2:" << str2 << "size:" << str2.size() << "capacity:" << str2.capacity();

    QString thisIsAString1_QS_m("taiga");
    using namespace Qt::Literals::StringLiterals;
    QT_BEGIN_NAMESPACE
    auto strAuto = "taiga"_L1;
    if (thisIsAString1_QS_m == strAuto) {
        qDebug() << "L1";
        if (thisIsAString1_QS_m == u"taiga") {
            qDebug() << "u";
        }
    }
    QT_END_NAMESPACE

    using namespace Qt::Literals::StringLiterals;
    QT_BEGIN_NAMESPACE
    auto str = u"hello"_s;
    QT_END_NAMESPACE
}

void TestQString::test26_macro_Printable()
{
    QString str1_QS_t("abcd");
    auto str2_c_tP = qPrintable(str1_QS_t);
    qDebug() << "1:" << str2_c_tP; //1: 错误的，该指针指向未知空间
    qDebug() << "2:" << qPrintable(str1_QS_t); //2: abcd
}
