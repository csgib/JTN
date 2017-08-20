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

    const QStringList imgloc = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    QUrl wlimgloc;

    wlimgloc = QString("%1").arg(imgloc.first());

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("montoto", wlimgloc);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
