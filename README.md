**Godot Multiplayer Simple Example**

Since there are only a handful of Godot multiplayer examples out there, I thought I would build my own simple example that you can use as a base for your projects!

I used the official godot documentation as a guide to create this project to ensure we get best practices in the code!

**Instructions**

1.  In the "builds" folder, open up the .exe file 4 times (or as many as you want!)
2.  One of these sessions should click the "host" button
3.  Then everyone else should click the "join" button
4.  The server must click the start button first (you will see errors, don't worry this is normal and to show you what is going on. Explained below)
5.  Then everyone else can hit their start buttons
6.  Once everyone has finished clicking the start buttons, the errors should stop and everyone should be able to control their own players!

Here you should see each client control their own player, and their position is sent to all other clients. You can scale this to as many players as you want!

**Warnings**
*  You will see errors when the server hits the start button. This is normal and here to show you example errors when the server is trying to send position to a client who doesn’t have their player setup yet! But as soon as you hit the start button on each client, the errors will stop and everyone can play without any errors.
*  There are not any safety functions such as handling disconnections, simultaneous start, etc. It's important but can be added later, what is most important is that you understand how the actual multiplayer works and can focus on a working prototype to test your game. The disconnection handling can come later and they are easy to implement after the fact. The documentation provides examples as well as the tutorials that I have linked below.

**Final**

I hope you find my simple multiplayer example helpful as a base for your multiplayer games. I hope this helps to complement the official documentation and help you to understand multiplayer. As said earlier, I will leave links below to tutorials that I found very helpful. If you find any, please feel free to comment below to help out the community and I will add them to the list. Please let me know if you have any problems, questions, or suggestions.  Thank you!

*  Official documentation: https://docs.godotengine.org/en/3.1/tutorials/networking/high_level_multiplayer.html 
*  How to make a simple chat room: http://www.narwalengineering.com/2018/07/01/godot-tutorial-simple-chat-room-using-multiplayer-api/
*  Simple 4 player space battle: https://godot3tutorials.wordpress.com/2018/03/02/part-1-multiplayer-tutorial/
*  Really good tutorial but had some trouble towards the end: https://youtu.be/JuRhRhJ2914
*  Very Awesome tutorial! But a little challenging since they are using http requests for logins. I definitely recommend this after you have your base setup and have a foundation in how multiplayer works: https://youtu.be/TGIWD24QIvY
*  This is a great all inclusive multiplayer example: https://www.youtube.com/watch?v=Xu3LtVihYoo

