#ifndef SETTINGS_MANAGER_H
#define SETTINGS_MANAGER_H

#include <QObject>
#include <QtDeclarative/qdeclarative.h>

class SettingsManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant accessToken  READ accessToken  WRITE setAccessToken  NOTIFY accessTokenChanged)
    Q_PROPERTY(QVariant refreshToken READ refreshToken WRITE setRefreshToken NOTIFY refreshTokenChanged)
public:
    explicit SettingsManager(QObject *parent = 0);

    QVariant accessToken() const;
    void setAccessToken(const QVariant& z);

    QVariant refreshToken() const;
    void setRefreshToken(const QVariant& z);
    Q_INVOKABLE void openUrl(const QString& url);


Q_SIGNALS:
    void accessTokenChanged();
    void refreshTokenChanged();

private:
    QString m_strAccessToken;
    QString m_strRefreshToken;
};

QML_DECLARE_TYPE(SettingsManager)

#endif // SETTINGS_MANAGER_H
