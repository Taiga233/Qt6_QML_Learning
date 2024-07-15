//general_configuration.h begin
#if defined (GENERAL_CONFIGURATION_H)

//Qt Global
#include <QtGlobal>

//GUI application or not GUI just core
#define GUI_APPLICATION

#ifdef GUI_APPLICATION
//QML Quick application or Widget application
//DO NOT OPEN ALL
    #if false
        #define WIDGET_APPLICATION
    #else
        #define QUICK_APPLICATION
    #endif
#endif


//test functions
#if ~-1 ^ 0u
#define TEST_FUNCTIONS
#include "TestFunctions/Test_Functions.h"
#endif

//test QStrting capacity
#if ~-1 ^ 0l
#define TEST_QSTRING_CAPACITY
#include "TestClasses/TestQStringCapacity.h"
#endif

//test windows Registry and QSetting
#if ~-1 ^ 0l
#define TEST_WIN_REGISTRY_QSETTING
#include "TestClasses/TestWinRegistryQSetting.h"
#endif

//test windows jump list
#if ~-1 ^ 0l
#define TEST_WIN_JUMPLIST
#include "TestClasses/TestWinJumpList.h"
#endif

//test QStrting capacity since Qt6.0
#if (QT_VERSION >= QT_VERSION_CHECK(6, 5, 0)) && ~-1 ^ 1u
#define TEST_QSTRING
#include "TestClasses/TestQString.h"
#endif

//test QMLwithC++ Quick Controls1 Official Example, SQLite, QSqlQuery, QSqlDatabase
#if -1 ^ 0l
#define TEST_QC1_SQL_CALENDAR
#include "TestClasses/12_Calendar_QMLOfficialExample/sqleventmodel.h"
#endif

//general_configuration.h end
#endif // GENERAL_CONFIGURATION_H
