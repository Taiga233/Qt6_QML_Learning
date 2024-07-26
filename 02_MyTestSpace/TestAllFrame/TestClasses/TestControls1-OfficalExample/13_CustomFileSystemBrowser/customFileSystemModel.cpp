/*! **********************************************************
 *  @File        : TestControls1OfficalExample.pi
 *  @Brief       : xxxxx
 *  @Details     : xxxxx
 *  @Author      : YiRongPeng
 *  @Email       : taiga_tora@foxmail.com
 *  @Date        : 2024-07-22 14:10:07
 *  @Version     : v1.0
 *  @System      : Windows/Linux/Unix
 *
 **************************************************************
 *
 *  @par modified log :
 *  @Attention        :
 *
 * This file is part of the QtWidgets module of the Qt Toolkit.
 * Copyright (C) 2024 The Qt Company Ltd.
 * Commercial License Usage
 * Licensees holding valid commercial Qt licenses may use
 * this file in accordance with the commercial license
 * agreement provided with the Software or, alternatively,
 * in accordance with the terms contained in a written
 * agreement between you and The Qt Company. For licensing
 * terms and conditions see
 * https://www.qt.io/terms-conditions.
 * For further information use the contact form at
 * https://www.qt.io/contact-us.
 *************************************************************/
#include "customFileSystemModel.h"

#include <QLocale>
#include <QUrl>
#include <QDateTime>

CustomFileSystemModel::CustomFileSystemModel(QObject *parent) : QFileSystemModel(parent)
{

}

//重写QFileSystemModel中的data函数
QVariant CustomFileSystemModel::data(const QModelIndex &index, int role) const
{
    //自定义数据
    if (index.isValid() && role >= SizeRole) {
        switch (role) {
        case SizeRole:
            return QVariant(sizeString(fileInfo(index)));
        case CustomFilePermissionsRole:
            return QVariant(permissionString(fileInfo(index)));
        case LastModifiedRole:
            return QVariant(QLocale::system().toString(fileInfo(index).lastModified(), QLocale::ShortFormat)); //根据本地系统时间的短格式来设定最后修改时间样式
        case UrlStringRole:
            return QVariant(QUrl::fromLocalFile(filePath(index)).toString());
        default:
            break;
        }
    }
    //原始数据
    return QFileSystemModel::data(index, role);
}

//Returns the model's names. //QML Role Name
QHash<int, QByteArray> CustomFileSystemModel::roleNames() const
{
    //原有的角色名字
    QHash<int, QByteArray> result = QFileSystemModel::roleNames();
    result.insert(SizeRole, QByteArrayLiteral("byteSize"));
    result.insert(CustomFilePermissionsRole, QByteArrayLiteral("customFilePermissions"));
    result.insert(LastModifiedRole, QByteArrayLiteral("lastModified"));
    return result;
}
