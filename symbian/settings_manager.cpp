#include "settings_manager.h"
#include <QSettings>
#include <QDebug>
#include <QDesktopServices>
#include <QUrl>

SettingsManager::SettingsManager(QObject *parent) :
    QObject(parent)
{
    QSettings::setPath(QSettings::NativeFormat, QSettings::UserScope, "qml/qml-google-books");

    m_strCompanyName = "ICS";
    m_strAppName = "QtBooks";
    QSettings settings(QSettings::UserScope, m_strCompanyName, m_strAppName);
    m_strAccessToken = settings.value("access_token", "").toString();
    m_strRefreshToken = settings.value("refresh_token", "").toString();

}

QVariant SettingsManager::accessToken() const
{
    return m_strAccessToken;
}

void SettingsManager::setAccessToken(const QVariant& token)
{
    m_strAccessToken = token.toString();
    QSettings settings(QSettings::UserScope, m_strCompanyName, m_strAppName);
    settings.setValue("access_token", m_strAccessToken);
}

QVariant SettingsManager::refreshToken() const
{
    return m_strRefreshToken;
}

void SettingsManager::setRefreshToken(const QVariant& token)
{
    m_strRefreshToken = token.toString();
    QSettings settings(QSettings::UserScope, m_strCompanyName, m_strAppName);
    settings.setValue("refresh_token", m_strRefreshToken);
}

void SettingsManager::openUrl(const QString& url)
{
    qDebug() << "SettingsManager::openUrl" << url;
    QDesktopServices::openUrl(QUrl(url));
}
