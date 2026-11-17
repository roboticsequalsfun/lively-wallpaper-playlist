#pragma once
#include "configSettings.h"

class FileManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE void openConfig(); 
    Q_INVOKABLE void openLogs();
    Q_INVOKABLE void createLogReport();
private:
    ConfigSettings *m_configSettings = nullptr;
    QString m_env;
};
