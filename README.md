## MarkHolmberg.com

###### [Mark Holmberg.com](http://www.markholmberg.com)

### My Custom Built Blogging Software Using Ruby on Rails


#### The Idea: Use Test Driven Development and RoR Best Practices

The idea behind creating this blogging software is to not only demonstrate a balanced approach to test-driven and behavior driven development, but also to show that one need not go to extremes when developing software using Ruby on Rails. I've tried my best to use the latest and *trendiest* gems and add-ons out there such as Can-Can, Twitter Bootstrap, Strong Parameters, etc.

#### The Implementation: Splitting Public and Private Controllers

Another key idea behind this blog is to separate out the "public" controllers from "administrative" controllers. While I'm sure there are flaws in almost every application, I've tried my best to test and ensure that no **normal** user can hit administrative and potentially destructive actions. I try to implement new functionality using the scaffold generators (although this can be quite a task as most of the generated stuff is useless), or by adding them in by hand. I've done my best to test every action using both functional, unit, and requst specs.

#### Not Your Standard Blog

Anyone can make a blog, but my intention was to make a blog that **stands out** and yet is *simple* for the end user. The intent is to have intuitive principles not only in the interface but in the design of the software itself. Things should just *"work"* the way you would expect. Unlike many blogs, I also intend to try my best at preventing spammers from polluting the database by requiring users to register in order to post comments on articles, and using Strong Parameters with Can-Can to prevent unauthorized users from using something like cURL to POST garbage.