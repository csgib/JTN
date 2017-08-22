#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStandardPaths>
#include <QStringList>
#include <QUrl>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // *** GET DEFAULT PATH FOR IMG AND DOWNLOAD ***

    // *** TODO : TEST IF RESULT IS EMPTY SO DEFINE FOLDERS ***

    const QStringList imgloc = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    const QStringList dowloc = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation);
    QUrl wlimgloc;
    QUrl wldowloc;

    wlimgloc = QString("%1").arg(imgloc.first());
    wldowloc = QString("%1").arg(dowloc.first());

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("wg_img_path", wlimgloc);
    engine.rootContext()->setContextProperty("wg_dow_path", wldowloc);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
