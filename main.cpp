#include <QtGui/QApplication>
#include <MDeclarativeCache>

#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(MDeclarativeCache::qApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/stopwatch/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
