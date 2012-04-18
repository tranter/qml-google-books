#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "settings_manager.h"


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;

    qmlRegisterType<SettingsManager>("ICS", 1, 0, "SettingsManager");

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/qml-google-books/main.qml"));
    viewer.showExpanded();

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);


    return app.exec();
}
