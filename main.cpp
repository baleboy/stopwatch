#include <QtGui/QApplication>
#ifndef QT_SIMULATOR
#include <MDeclarativeCache>
#endif

#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#ifndef QT_SIMULATOR
    QScopedPointer<QApplication> app(MDeclarativeCache::qApplication(argc, argv));
#else
    QScopedPointer<QApplication> app(new QApplication(argc, argv));
#endif
    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/stopwatch/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
