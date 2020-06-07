# loblaws

This is an exciting app that fetches swift news from reddit.

Few things about the architecture.

I have used MVVM archicture keeping modularization and scaling in mind.
VM binding with view is done using generic Observable called Box<T>

I have also used a factory pattern to have easy access to all viewcontroller (screen) at one place

For navigation to other view controller I have used delegate pattern.
I have done all my view in code, so no xib or storyboard. 

Assumption: I have assumed that article body (to be shown on the detailed page) is the actual article. So I have showed that in web view as there was no other json field that gives us raw article body.

For questions you can email me at aliasgar.mala@gmail.com
