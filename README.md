# Radar Graph Scripted Gui 

A scripted gui template for you do create your own radar diagram.

Require some basic knowledge of hoi4 gui files and scripted gui.

## How does it worked
TODO, shader shenanigens, not important anyway.

## **How to use:**

To start with, let's think about where we want to use a radar graph and the style( color size etc. ).

By default the graph is fit within a 200px*200px square, but don't worry if you'd like sth different since it's easy to tweak its size.

Let's say we want to create a JOJO style stand stats on top of our leader, so with some measurements we can see we have around 150px to work with.

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

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/daaba7f4-c7c5-4f7f-8ccb-cb83ada9d3cd)

You'd also need to create a 200px square texture under "gfx\radar_graph", purple color and you can play around with the opacity to see which one you prefer. I used 75% for this demo.

![image](https://github.com/CMCMC404/CM-HOI4-Random-Crap/assets/69458655/fed9ad77-35d0-47da-82f6-c63497b3afd1)

By now we have finished creating a purple hexagon template. Time to move on to the scripted gui part.

##  

N



