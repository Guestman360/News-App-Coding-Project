# The News App

![News App Screenshot](https://i.imgur.com/jKOMDqP.png)

A simple news app that pulls its articles from a json endpoint. The app itself is pretty straightforward, you have a tableview with sections each holding articles of a particular topic, you have a detail view where you can choose to open the full article in your preferred browser and finally there is a basic search functionality.

To give some more info on my thought process for the project, I opted for a MVVM approach which I feel is a better pattern than MVC because it allows views to focus on displaying information and the view models on updating the views when necessary. MVVM allows us to mitigate the issue of "massive view controller" and separate logic out of views. I also leveraged a few extensions that I felt were not only intuitive but also extremely helpful in the project. Some extensions include improving image loading in tableview cells, which also caches images to help improve performance, as well as an extension on URLSession which mainly helped with improving the usage of Swift's Result type and better handling success/failure cases with network requests.

One of the biggest challenges I had with this project was handling the requirement where subsequent tableview cells after the first needed to contain 2-3 articles in one cell. I struggled with this a lot and the solution I ultimately settled on was to dynamically create views from a Xib file with the necessary article information and load them into a tableview cell stackview. This way the cell would load up multiple items per cell dynamically and the stack view would accomodate the size of all items within it. The logic worked well and held up on both iPhone and iPad. 
