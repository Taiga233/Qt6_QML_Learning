#include "general_configuration.h"

#ifdef GUI_APPLICATION
    #if defined(WIDGET_APPLICATION)
        #include <QApplication>
        #include <QWidget>
    #elif defined(QUICK_APPLICATION)
        #include <QGuiApplication>
        #include <QQmlApplicationEngine>
        #include <QQmlContext>
    #else
        #include <QApplication>
    #endif
#else
#include <QCoreApplication>
#endif

//declare funtion
int testAllConsoleClasses(); //all console classes
int testAllWidgetGUIClasses(); //all widget frame based on GUI classes
int setAllContextProperty(QQmlApplicationEngine &); //all C++ QML context property
int registerAll(); //all register type

//main
int main(int argc, char *argv[])
{
    #ifndef GUI_APPLICATION
    QCoreApplication app_core(argc, argv);
    #else
        #if defined(WIDGET_APPLICATION)
            QApplication app_(argc, argv);
            QWidget w;
            w.show();
        #elif defined(QUICK_APPLICATION)
            //high Dpi qt6
            //Attribute Qt::AA_EnableHighDpiScaling must be set before QCoreApplication is created.
            #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
                QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
            #endif

            QGuiApplication app_gui(argc, argv);
            QQmlApplicationEngine engine;
            if (setAllContextProperty(engine)) return -1;
            if (registerAll()) return -1;
        #else
        #endif
    #endif

    #ifndef GUI_APPLICATION
    if (testAllConsoleClasses()) return -1; //test all classes without GUI
    return app_core.exec();
    #else
        #if defined(WIDGET_APPLICATION)
            if (testAllWidgetGUIClasses()) return -1; //test all classes without Quick
            return app_.exec();
        #elif defined(QUICK_APPLICATION)
            const QUrl url(QStringLiteral("qrc:/main/main.qml"));
            QObject::connect(
                &engine,
                &QQmlApplicationEngine::objectCreated,
                &app_gui,
                [=](QObject *obj, const QUrl &objUrl) {
                    //defining an anonymous function object
                    if (!obj && url == objUrl) {
                        QCoreApplication::exit(-1);
                    }
                },
                Qt::QueuedConnection);
            engine.load(url);
            if (engine.rootObjects().isEmpty()) {
                return -1; //Prevents loading failure
            }
            return app_gui.exec();
        #else
            QCoreApplication::exit(-1);
        #endif
    #endif
}

int testAllConsoleClasses()
{

//1st
#ifdef TEST_QSTRING_CAPACITY
    {
        //for test
        TestQStringCapacity testQStringCapacity_t(&app_core);
        // testQStringCapacity_t.test_m();
        // test_t.test_QChar();
        // test_t.test_QString_arg();
    }
#endif

//2nd
#ifdef TEST_QSTRING
    {
        TestQChar test_QChar_t;
        // test_QChar_t.test_QChar();
        TestQString test_QString_t;
        test_QString_t.run_test_function();
    }
#endif

    return 0;
}

int testAllWidgetGUIClasses()
{

//1st
#ifdef TEST_WIN_REGISTRY_QSETTING
    {
        QStringList fileTypes = {".jpg", ".png"};
        app_.setApplicationDisplayName("for test WIN_REGISTRY");
        TestWinRegistryQSetting::associateFileTypes(fileTypes);
    }
#endif

//2nd
#ifdef TEST_WIN_JUMPLIST
    {
        TestWinJumpList jumpList(&w);
        jumpList.showJumpList();
    }
#endif

    return 0;
}

int setAllContextProperty(QQmlApplicationEngine &engine) {
    Q_UNUSED(engine)
    // 把类的实例化对象 myConfiguration 设置为上下文属性
    // 可以在所有qml文件中通过 applicationConfiguration 来调用该类的属性和方法
    // MyConfiguration myConfiguration;
    // engine.rootContext()->setContextProperty("applicationConfiguration", &myConfiguration);
    return 0;
}

int registerAll() {

//1st
#ifdef TEST_QC1_SQL_CALENDAR
    qmlRegisterType<SqlEventModel>("TestClasses.QC1.OfficialExampleCalendar", 1, 0, "SqlEventModel");
#endif

    return 0;
}
