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
#ifndef CUSTOMFILESYSTEMMODEL_H
#define CUSTOMFILESYSTEMMODEL_H

#include <QFileSystemModel>
#include <QObject>

class CustomFileSystemModel : public QFileSystemModel
{
    Q_OBJECT
public:
    explicit CustomFileSystemModel(QObject *parent = nullptr);

    //自定义角色
    enum Roles  {
        SizeRole = ((Qt::UserRole + 3 == QFileSystemModel::FilePermissions) ? (Qt::UserRole + 4) : (QFileSystemModel::FilePathRole + 1)), //0x0104
        CustomFilePermissionsRole,
        LastModifiedRole,
        UrlStringRole
    };
    //This function is obsolete. It is provided to keep old source code working. We strongly advise against using it in new code.
    //In new code, you should prefer the use of the Q_ENUM() macro, which makes the type available also to the meta type system.
    Q_ENUM(Roles)

    // QAbstractItemModel interface
public:
    //重写QFileSystemModel中的data函数
    QVariant data(const QModelIndex &index, int role) const override;
    //重写QAbstractItemModel中的roleNames函数
    QHash<int, QByteArray> roleNames() const override;
};

//file permissions:

static inline QString permissionString(const QFileInfo &fi)
{
    const QFile::Permissions permissions = fi.permissions();
    QString result = QLatin1String("----------");
    if (fi.isSymLink()) {
        result[0] = QLatin1Char('l');
    } else if (fi.isDir()) {
        result[0] = QLatin1Char('d');
    } else {
        result[0] = QLatin1Char('-');
    }

    if (permissions & QFileDevice::ReadUser)
        result[1] = QLatin1Char('r');
    if (permissions & QFileDevice::WriteUser)
        result[2] = QLatin1Char('w');
    if (permissions & QFileDevice::ExeUser)
        result[3] = QLatin1Char('x');
    if (permissions & QFileDevice::ReadGroup)
        result[4] = QLatin1Char('r');
    if (permissions & QFileDevice::WriteGroup)
        result[5] = QLatin1Char('w');
    if (permissions & QFileDevice::ExeGroup)
        result[6] = QLatin1Char('x');
    if (permissions & QFileDevice::ReadOther)
        result[7] = QLatin1Char('r');
    if (permissions & QFileDevice::WriteOther)
        result[8] = QLatin1Char('w');
    if (permissions & QFileDevice::ExeOther)
        result[9] = QLatin1Char('x');
    return result;
}

//human readable file size:
static inline QString sizeString(const QFileInfo &fi)
{
    if (!fi.isFile())
        return QString();
    const qint64 size = fi.size();
    if (size > static_cast<qint64>(1024) * 1024 * 1024 * 10)
        return QString::number(size / (1024 * 1024 * 1024)) + QLatin1Char('G');
    if (size > 1024 * 1024 * 10)
        return QString::number(size / (1024 * 1024)) + QLatin1Char('M');
    if (size > 1024 * 10)
        return QString::number(size / 1024) + QLatin1Char('K');
    return QString::number(size) + QLatin1Char('B');
}

#endif // CUSTOMFILESYSTEMMODEL_H
