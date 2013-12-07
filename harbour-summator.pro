# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-summator

CONFIG += sailfishapp

SOURCES += src/harbour-summator.cpp

OTHER_FILES += qml/harbour-summator.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-summator.spec \
    rpm/harbour-summator.yaml \
    harbour-summator.desktop \
    qml/pages/About.qml \
    qml/pages/Landing.qml \
    qml/pages/GameScreen.qml \
    qml/pages/HighScores_old.qml \
    E:/highscore.qml \
    qml/pages/highscore.qml \
    qml/pages/FirstPage.qml

