import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import com.vv.exampleclass 1.0
import QtQuick.Controls 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    // ElementUser, NewData - компоненты созданные в QML
    property string sc: 'ElementUser{width:600; height:150;}' // Шаблон создания нового компонента !!!!!!!
    property string nc: 'NewData{width:600; height:150;}'

    property int num: 0
    property NewData newData: value
    function addThisData(town, info)
    {
        loader.writeNewInformation(town, info)
        var itog = sc + 'townname:{"' + town + '"};towninfo:{"' + info + '"}' //  !!!!!!!
        var el = Qt.createQmlObject(itog, list, "obj" + num++)
    }
    BaseReader{
        id: loader
        onInitEnd:
        {
            if (succeed) // см. объявление сигнала initEnd
                // добавляем компонент для добавления нового города
            {
                newData = Qt.createQmlObject(nc, list, "objdata")
                loader.hetNextRecord() // Запрашиваем у класса информацию о городе
            } else Qt.quit()
        }
        onLoadTown: {
            var itog = sc + 'townname:"' + town + '";towninfo:"' + info + '"}' // формируем описание нового элемента !!!!!!!!
            var el = Qt.createQmlObject(itog, list, "obj" + num++)
            loader.getNextRecord() // Запрашиваем информацию о следующем городе
        }
    }
    ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        anchors.fill:parent // Заполняем всю область родительского объекта
        Component.onCompleted: loader.loadBase()
        ColumnLayout {
            id: list
            function add(town, info) {
                root.addThisDate(town, info)
                console.log(town)
                console.log(info)
            }
        }
    }


}












