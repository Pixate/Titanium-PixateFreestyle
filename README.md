# Titanium-Pixate Module

**THIS IS AN EARLY RELEASE AND NOT YET PRODUCTION READY**

## Requirements

The Titanium-Pixate module requires **Titanium 3.0.0.GA** or greater.

## Installing the Module

See [Using Titanium Modules](https://wiki.appcelerator.org/display/tis/Using+Titanium+Modules) for information on how to install the module into your project.

## Configuting **tiapp.xml**

You can use the Ti Studio interface to add the Pixate Engine module into your project, or just edit the tiapp.xml file directly and add this to your <modules> section:

	<module platform="iphone">com.pixate.pxengine</module>

## Setting the License Information

In your **tiapp.xml** file, add this section:

	<ios>
	    <plist>
	        <dict>
	            <key>PXuser</key>
	            <string>LICENSE USERNAME</string>
	            <key>PXkey</key>
	            <string>LICENSE KEY</string>
	        </dict>
	    </plist>
	</ios>

Be sure to substitute **LICENSE USERNAME** and **LICENSE KEY** with the information you received from the Pixate store.

## Styling your Controls

When creating a control, just use **styleId**, **styleClass**, and/or **styleCSS**. For example:


	var label = Ti.UI.createLabel({
		text:String.format(L('welcome'),'Titanium'),
		height:'auto',
		width:'auto',
		styleCSS:'background-color: blue; color:white;'
	});
	self.add(label);

	var button1 = Titanium.UI.createButton({
		title:'I am a Button 1',
		width:200,
		height:40,
		top:60,
		styleId:'myButton',
		styleClass:'myButtons'
	});
	self.add(button1);

	var button2 = Titanium.UI.createButton({
		title:'I am a Button 2',
		width:200,
		height:40,
		top:110,
		styleId:'myButton2',
		styleClass:'myButtons'
	});
	self.add(button2);


If using Alloy, just set **styleId**, **styleClass**, and/or **styleCSS** in your XML:

	<Alloy> 
		<Window class="container"> 
			<Label id="label" styleId="myLabel" onClick="doClick">Hello, World</Label> 
		</Window> 
	</Alloy>

## CSS

Add a **default.css** file into your project's **Resources** folder. Here's an example:

	#myLabel {
	 color: blue;
	 background-color: linear-gradient(gray,yellow);
	}

	#myButton {
	  background-color: linear-gradient(red,green);
	  border-radius: 20;
	  color: white;
	}

	#myButton2 {
	  background-color: linear-gradient(red,white);
	  border-radius: 20;
	  color: white;
	}

	#myButton2:highlighted {
	  background-color: linear-gradient(blue,yellow);
	  border-radius: 20;
	  color: red;
	}
