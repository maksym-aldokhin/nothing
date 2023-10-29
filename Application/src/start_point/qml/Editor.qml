import QtQuick 2.15

Item {
	id: root

	MouseArea {
		id: mouseArea

		anchors.fill: parent

		enabled: true

		acceptedButtons: Qt.LeftButton | Qt.RightButton

		onPressed: (mouse)=> {
			if (mouse.button === Qt.LeftButton) {
				rectangle.visible = true;

				internal.startPoint.x = mouseX;
				internal.startPoint.y = mouseY;
			}
		}

		onPositionChanged: (mouse)=> {
			if (mouse.buttons & Qt.LeftButton) {
				var end = Qt.point(Math.max(0, Math.min(mouse.x, mouseArea.width)),
								   Math.max(0, Math.min(mouse.y, mouseArea.height)));
				var x = Math.min(internal.startPoint.x, end.x);
				var y = Math.min(internal.startPoint.y, end.y);
				var width = Math.abs(internal.startPoint.x - end.x);
				var height = Math.abs(internal.startPoint.y - end.y);

				internal.rect = Qt.rect(x, y, width, height);
			}
		}
	}
	Rectangle {
		id: rectangle

		visible: false

		x: internal.rect.x
		y: internal.rect.y
		width: internal.rect.width
		height: internal.rect.height

		color: 'red'
	}

	QtObject {
		id: internal

		property point startPoint: Qt.point(0, 0)
		property rect rect: Qt.rect(0, 0, 0, 0)
	}
}
