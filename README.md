# Titanium-PixateFreestyle Module

## Requirements

The Titanium-PixateFreestyle module requires **Titanium 3.0.0.GA** or greater.

## Installing the Module

Unzip [the module](https://github.com/Pixate/Titanium-PixateFreestyle/releases) into your project's modules directory or install it globally. See [Using Titanium Modules](https://wiki.appcelerator.org/display/tis/Using+Titanium+Modules) for information on how to install the module globally.

## Configuring **tiapp.xml**

You can use the Ti Studio interface to add the Pixate module into your project, or just edit the tiapp.xml file directly and add this to your <modules> section:

	<module platform="iphone">com.pixate.framework</module>

## Adding the PixateFreestyle Runtime Properties

To let PixateFreestyle configure itself for working with Titanium, you'll need to update your **tiapp.xml** file by adding this entry:

	<ios>
	    <plist>
	        <dict>
        		<key>PXTitanium</key>
        		<true/>
	        </dict>
	    </plist>
	</ios>

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


If using Alloy, just set **styleId**, **styleClass**, and/or **styleCSS** (yes, you can inline CSS) in your XML:

	<Alloy>
		<Window class="container">
			<Label id="label" styleId="myLabel" onClick="doClick">Hello, World</Label>
			<Button id="button" styleCSS='background-color: blue; color: white;' onClick="doClick">Click Me</Button>
		</Window>
	</Alloy>

## CSS

Add a **default.css** file into your project's **Resources** folder. For Alloy users, add the file directly inside your **assets** folder. Here's an example CSS file:

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

## Alloy Users

You can use your **.tss** files to layout your controls, or you can use just the **.css** files to do so. If using **.css** for layout, your **.tss** file needs to either **not** set the layout property or set it to **absolute**.

	".container": {
		layout: 'absolute'
	}

Here's a sample .xml file:

	<Alloy>
		<Window class="container" styleId='container'>
			<Label id="label" styleId='myLabel' onClick="doClick">Hello, World</Label>
			<Button id="button" styleId='myButton' onClick="doClick">Click Me</Button>
		</Window>
	</Alloy>

With it's accompanying .css file:

	#container {
		background-color: linear-gradient(black,white);
	}

	#myLabel {
	    color: blue;
	    background-color: yellow;
	  	position: 0 200;
	    size: 100;
	}

	#myButton {
		position: 0 100;
		size: 100 50;
		color: white;
		border-radius: 10;
		transform : rotate(45);
		background-color: linear-gradient(red,blue);
	}


## Build Instructions

If you'd like to build the module yourself, this is the simple process. After cloning this project, start by creating a symbolic link to the PixateFreestyle framework file from your PixateFreestyle distribution in the PixateFreestyle folder. For example:

	cd PixateFreestyle
	ln -s ~/Documents/PixateFreestyle/PixateFreestyle.framework

Now just run build.py:

	./build.py

The resulting zip file can found in the PixateFreestyle directory. You may need to update your **titanium.xcconfig** file with the location of your SDK and version.

### Common Build errors

* If you see an error that 'PixateFreestyle/PixateFreestyle' could not be found, then you may be missing the symbolic link to PixateFreestyle.framework or it may be pointing to an invalid location. This will also show as an error coming from CompileC
* If you see an error about a missing "tools" module, then your TITANIUM_SDK environment variable may not be pointing to your Titanium installation. You can update the SDK path and version in the titanium.xcconfig file. Be sure to verify if your SDK has been installed in /Library/... versus ~/Library and update TITANIUM_SDK accordingly.
* Xcode may need to be closed if you encounter CompileC errors

## License

License for the included source is available in the accompanying [LICENSE](https://github.com/Pixate/Titanium-PixateFreestyle/blob/master/PixateFreestyle/LICENSE) file.

