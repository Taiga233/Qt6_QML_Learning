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
int otherConfiguration(); //other configuration
int testAllConsoleClasses(); //all console classes
int testAllWidgetGUIClasses(QWidget &); //all widget frame based on GUI classes
int setAllContextProperty(QQmlApplicationEngine &); //all C++ QML context property
int registerAll(); //all register type

//main
int main(int argc, char *argv[])
{
    #ifndef GUI_APPLICATION
    QCoreApplication app_core(argc, argv);
    if (otherConfiguration()) return -1;
    #else
        #if defined(WIDGET_APPLICATION)
            QApplication app_(argc, argv);
            if (otherConfiguration()) return -1;
        #elif defined(QUICK_APPLICATION)
            //high Dpi qt6
            //Attribute Qt::AA_EnableHighDpiScaling must be set before QCoreApplication is created.
            #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
                QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
            #endif

            QApplication app_gui(argc, argv);
            if (otherConfiguration()) return -1;

            QQmlApplicationEngine engine;
            if (registerAll()) return -1;
            //after register all qml instance:
            if (setAllContextProperty(engine)) return -1;
        #else
        #endif
    #endif

    #ifndef GUI_APPLICATION
    if (testAllConsoleClasses()) return -1; //test all classes without GUI
    return app_core.exec();
    #else
        #if defined(WIDGET_APPLICATION)
            QWidget w;
            if (testAllWidgetGUIClasses(w)) return -1; //test all classes without Quick
            w.show();
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

int otherConfiguration()
{
//1st quick Project14.
#ifdef TEST_QC1_VARIOUS_PLATFORM_GALLERY
    //OpenGL版本及兼容性设置
    if (QCoreApplication::arguments().contains(QLatin1String("--coreprofile"))) {
        QSurfaceFormat fmt;
        //Sets the desired major and minor OpenGL versions.
        fmt.setVersion(4, 4);
        //This setting is ignored if the requested OpenGL version is less than 3.2
        fmt.setProfile(QSurfaceFormat::CoreProfile); //Functionality deprecated in OpenGL version 3.0 is not available.
        QSurfaceFormat::setDefaultFormat(fmt);
    }
#endif

    return 0;
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

int testAllWidgetGUIClasses(QWidget &w)
{
    Q_UNUSED(w)

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

int setAllContextProperty(QQmlApplicationEngine &engine)
{
    Q_UNUSED(engine)
    // 把类的实例化对象 myConfiguration 设置为上下文属性
    // 可以在所有qml文件中通过 applicationConfiguration 来调用该类的属性和方法
    // MyConfiguration myConfiguration;
    // engine.rootContext()->setContextProperty("applicationConfiguration", &myConfiguration);

    /*setContextProperty()函数：将 C++ 对象或值设置为 QML 上下文的属性，这样 QML 文件中就可以通过属性名直接访问它
    优点：
        1.简单直接，适用于将单例或全局对象暴露给 QML。
        2.不需要复杂的类型匹配或注册。
    缺点：
        3.不支持类型安全，QML 编辑器可能无法提供自动补全或类型检查。
        4.只能在 QML 文件中访问一个特定的实例（通常是单例）。
    */

#ifdef TEST_QC1_FILESYSTEM_BROWSER
    //将该QFileSystemModel加入到QObject对象树管理，使用父指针指向子对象
    QFileSystemModel *fsm_QFSM_t_p = new CustomFileSystemModel(&engine);
    fsm_QFSM_t_p->setRootPath(QDir::homePath());
    fsm_QFSM_t_p->setResolveSymlinks(true);
    engine.rootContext()->setContextProperty("customFSysModel", fsm_QFSM_t_p);
    engine.rootContext()->setContextProperty("rootPathIndex", fsm_QFSM_t_p->index(fsm_QFSM_t_p->rootPath()));
#endif

    return 0;
}

int registerAll()
{

//1st
#ifdef TEST_QC1_SQL_CALENDAR
    /*qmlRegisterType方式注册：
    优点：
        1.QML 文件中可以直接使用注册的类型，创建其实例，并与其进行交互。
        2.支持类型安全，QML 编辑器（如 Qt Creator）可以提供自动补全和类型检查。
        3.适用于需要多个实例的情况，因为 QML 可以直接创建和管理这些实例。
    缺点：
        4.需要 C++ 类与 QML 之间进行明确的类型匹配。
        5.如果类具有复杂的构造函数或需要特定的初始化逻辑，可能需要额外的设置。
    */
    qmlRegisterType<SqlEventModel>("TestClasses.QC1.OfficialExample.Calendar", 1, 0, "SqlEventModel");
#endif

//2nd
#ifdef TEST_QC1_FILESYSTEM_BROWSER
    //qmlRegisterUncreatableType()注册一个C++类型，该类型不可实例化，但应可识别为QML类型系统的类型。如果类型的枚举或附加属性应该可以从QML访问，但是类型本身不应该是可实例化的，那么这很有用。
    qmlRegisterUncreatableType<CustomFileSystemModel>("TestClasses.QC1.OfficialExample.CustomFileSystemModel", 1, 0, "CustomFSysModel", "Cannot create a CustomFSysModel instance.");
#endif

    return 0;
}
