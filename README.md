# Radar Graph Scripted Gui 

A scripted gui template for you do create your own radar diagram.

Require some basic knowledge of hoi4 gui files and scripted gui.

## How does it worked
TODO, shader shenanigens, not important anyway.

## **How to use:**

To start with, let's think about where we want to use a radar graph and the style( color size etc. ).

By default the graph is fit within a 200px*200px square, but don't worry if you'd like sth different since it's easy to tweak its size.

Let's say we want to create a JOJO style stand stats on top of our leader, so with some measurements we can see we have around 150px to work with.

So for simplicity we'll just use a 100*100px chart, since we need some space for margin.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/1674e573-c299-494f-8232-8b662b8f1868)

I'm gonna use this picture of the greatful dead as a reference. So basically purple hexagonal diagram on a yellow background.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/1b29871c-4e42-44f0-b831-f0bef77adf2d)

## 

Navigate to "interface\cm_radar_graph", here is the place that stores all the templates for radar chart. My naming scheme is pretty straight forward, numbers means how many sides and suffix tells the color.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/dfef01cd-6778-4894-a2f0-0d3dcae3d1a1)

We don't have a purple hexagonal template, so let's create one, start by copying cm_radar_graph_06_yellow.gui, and rename it, in this case I'd simply called it 06_purple.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/260de3d8-ea69-4e65-bf19-f79386eea3f8)

Open it and rename the container window's name and each icons' gfx path, for simplicity I just batch replaced "yellow" with "purple". 

You will get sth like this:

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/dd672202-43f2-441d-b902-a2b872e65d71)

Noted there's a rotation attribute under icontype and it's radian in decimal. For example 60 degrees is 1/3Pi and equals to 1.0471.

## 

Then open cm_radar_graph.gfx and make a copy of GFX_radar_icon_06_yellow and change the suffix to purple as well.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/aaf29ae1-6287-4a78-9674-978f397f701e)


You'd also need to create a 200px square texture under "gfx\radar_graph", purple color and you can play around with the opacity to see which one you prefer. I used 75% for this demo.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/fed9ad77-35d0-47da-82f6-c63497b3afd1)

By now we have finished creating a purple hexagon template. Time to move on to the scripted gui part.

##  

First I created jojo_example.gui and jojo_example.gfx, I made a 170*170px window in the gui file and added the background texture I just made in the gfx file.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/3a9bc600-d0e9-4ee9-b997-79aac6f910ac)


![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/c46710a2-c54d-4803-9954-9b2ab2c78e92)

Then added a new scripted gui file in common and tied the window we just created to political tab.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/8e5987f8-520c-47b0-ab3d-3961c027226e)

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/f59848e1-0c62-4fc2-8663-bdb05ba0ce94)

After that edit the xy attribute and put the window in the right place, meanwhile also add a icontype and put the bg texture in.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/0f5e583f-aea0-4fe3-afdc-fd4e5fa2a707)

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/71cabad7-a4c6-4ce2-9a6f-0cb8fe0bf51a)

## 

This is an important part, we will create a dummy window to controll the position and size of our chart. As I mentioned before the default size is 200px but we want 100px graph so we need to shrink it down by half in the scale attribute.

And after some calculation we'd know to fit 100px square in the center of a 170px square the position would be 35,35

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/a7154fa9-3f26-45cb-813a-dfc59864e0ad)

Hop back to scripted gui file and add a new entry, this time we'll link the template created prior to the dummy window.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/5e8f622b-0b63-417f-bfc0-c56effecf1a4)

You can see some small puple pixels in the middle of the texture, that means our template is working, but we still need to feed it some data so that it'll actually show sth.

Let's add "radar_icon_6_1 = { frame = 9999 }" in the properies attribute of our scripted gui, and we can see there's a full purple triangle showing up.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/702a40d3-1bdf-4080-86ea-60f9843fc1a3)
![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/fbab3fd0-39c8-44b3-8432-4163c6417c9e)

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/7cb56c22-4428-4cca-9be5-1354d33d597a)

## 

Time to set some variable to feed to the icons, like I said in the begining the shader will break a 4 digits number into to two 2 digits ones.

So we need to create sth equals to int(str(a) + str(b)) to create the 4 digits number in the first place.

This might look daunting but you'd get what I refers to by a simple example.

Let's say a is twelve and b is thirty four, so instead of 12 + 34 = 46 what we want is '12' + '34' = '1234'.

Actually quite simple if you think about it, all we need is a * 100 + b, with that in mind I'm gonna create a effect that do just that.

But first I'm gonna make a button to execute the effect and also function as a switch so this ui won't always stands in front of our leader's face.
![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/710ae84f-e986-4753-afc3-0e4fb72efd4b)

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/49212a72-3da5-400b-86c9-37cbe8fd27c0)

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/238ca966-13f0-4e63-8cab-0cda07ab36c0)

Now that we have a effect entry I'm just gonna dumped the whole code to you.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/c61101b4-9ac1-4e66-b5b9-27d41be99dbb)

This wall of text basically means put all our data in a input array, then do the calculation and extract the result to a output array.
NOTED: you'd need to clamp the input variable between [0,100), it can't exceed 99 or the shapes will break.

Finally set the properties of our template's icon frame to the correspoding output array item.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/a1fb5597-9768-4fc4-9061-6d0f841c18d0)

And voila, there you go, now you should know how the basics work it's time to create your own cool stuffs in-game.
![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/1bb62e76-dcde-4c42-a618-e6b97b7ab6e7)


