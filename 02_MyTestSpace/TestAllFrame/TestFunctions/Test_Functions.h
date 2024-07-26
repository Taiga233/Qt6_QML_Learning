#ifndef TEST_FUNCTIONS_H
#define TEST_FUNCTIONS_H

#include <QByteArray>

void g_Func_test() {
    // ...
}

//使用QByteArray::fromHex会导致某些字符转失败，所以自己做了个
QByteArray g_Func_fromHexAll(const QByteArray &asciiHex)
{

    if (asciiHex.isEmpty()) {
        // qDebug() << "asciiHex is Empty!!!";
        return QByteArray();
    }

    QByteArray res((asciiHex.size() + 1) / 2, Qt::Uninitialized);
    uchar tmp_uc_t = 0;
    QString tmp_QS_t;
    bool ok = true;
    uint okTimes_ui_t = 0;

    for (int pos = 0, var = 0; var < asciiHex.size(); ++var, pos = (var + 1) / 2) {
        tmp_QS_t.clear();
        tmp_QS_t.append(asciiHex.at(var));
        if (Q_LIKELY(++var < asciiHex.size())) {
            tmp_QS_t.append(asciiHex.at(var));
        }
        // qDebug() << "tmp_QS_t:" << tmp_QS_t;
        tmp_uc_t = (uchar)tmp_QS_t.toUShort(&ok, 16);
        ok || (ok = !ok, ++okTimes_ui_t);
        // qDebug() << "toUShort:" << Qt::hex << Qt::showbase << tmp_QS_t.toUShort(&ok, 16);
        res[pos] = tmp_uc_t;
    }
    if (okTimes_ui_t) {
        // qDebug() << "okTimes_ui_t:" << okTimes_ui_t;
    }
    return res;
}

#endif // TEST_FUNCTIONS_H
