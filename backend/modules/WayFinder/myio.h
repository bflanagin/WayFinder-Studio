#ifndef MYIO_H
#define MYIO_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QStandardPaths>
#include <QCryptographicHash>

class MyIOout : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString store READ store WRITE file NOTIFY filesaved )
    Q_PROPERTY( QString create READ create WRITE directory NOTIFY filesaved )


public:
    explicit MyIOout(QObject *parent = 0);
    ~MyIOout();

Q_SIGNALS:
    void filesaved();

protected:

    QString store() {return m_message; }
    QString create() {return m_message; }


    void file(QString msg) {

        QString home = QDir::homePath();
        QString data = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

            QDir things(data);
                QString direct = msg.split(",")[0];
                QString filepath = msg.split(",")[1].split("://")[1];
                QString filename = filepath.split("/").last();
            QString wherearewe = things.path()+"/images/"+direct+"/"+filename;
            QFile::copy(filepath,things.path()+"/images/"+direct+"/"+filename);

            m_message = wherearewe;

    }

    void directory(QString msg) {

        QString home = QDir::homePath();
        QString data = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

            QDir things(data);
            QString avatarpath =things.path()+"/images/avatar/";
            QString samplepath =things.path()+"/images/sample/";
            QString librarypath =things.path()+"/images/library/";
            QString coverspath =things.path()+"/images/covers/";
            things.mkpath(avatarpath);
            things.mkpath(samplepath);
            things.mkpath(librarypath);
            things.mkpath(coverspath);

            m_message = "created directories:\n"+avatarpath+"\n"+samplepath+"\n"+librarypath+"\n";

    }


    QString m_message;
};

#endif // MYTYPE_H
