#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "mytype.h"
#include "myio.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("WayFinder"));

    //qmlRegisterType<MyType>(uri, 1, 0, "MyType");
    qmlRegisterType<MyIOout>(uri, 1, 0, "MyIOout");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

