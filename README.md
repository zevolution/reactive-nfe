
<center><img src="https://user-images.githubusercontent.com/36534847/85956631-6e30a400-b95d-11ea-9ab9-5ddd83bf57f4.png" alt="NFe-Logo" width="150" height="150"></center>
<h1><center> Reactive-NFe </center><h1>

![GIF 28-06-2020 17-19](https://user-images.githubusercontent.com/36534847/85957476-fd40ba80-b963-11ea-97fb-f3fe777b7713.gif)

## Table of contents
- [About the project](#about-the-project)
- [Description](#description)
- [Built with](#built-with)
- [Installation](#instalation)
- [Run](#run)
- [Notes](#notes)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## About the project
Reactive-NFe is an old project(begin 2019), wherein I was training interface design for Delphi. I decided to resume it because I was missing Delphi, after 10 months of programming in Java without stopping, hahaha.

## Description
This project basically contains:
* A simple example of how to create application interfaces that are very attractive and provide rich interaction to the user
* An introduction to Reactive Programming, using two of its four pillars ([see more](https://www.reactivemanifesto.org/)):
  * [x] Responsive - A system of NFe which the user can monitor the status of each NFe in real-time
  * [] Resilient
  * [] Elastic
  * [x] Message Driven - We use an asynchronous message to establish communication between our view-layer and infrastructure-layer
* Cache service to the principal numbers in user dashboard
* My vision of how to would be a software development approach in which design is domain-driven(DDD), described in the book of [Uncle Bob](https://www.amazon.com.br/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215), applied in Delphi

## Built with
* [FireMonkey Framework](https://en.wikipedia.org/wiki/FireMonkey) in [Delphi](https://www.embarcadero.com/products/delphi) Tokyo 10.2.3
* [Redis](https://redis.io/) 5.0.3

## Installation

1. To clone and run this application, you'll need Git installed on your computer(or no, if you want to download **.zip**). From your command line:
```bash
# Git CLI
git clone https://github.com/zevolution/reactive-nfe.git

# Github CLI
gh repo clone zevolution/reactive-nfe
```
2. You must have `Redis` installed on your computer. We use PUB/SUB of Redis to insert and change the state of the NFe's in the view-layer. Below in [Notes](#notes), I will provide some links that can help you.

3. To use Redis as a primary cache service, you must add the 3 primary keys to the cache. After connecting in Redis via redis-cli use the commands below:
```bash
SET numerodeclientes 18729
SET numerodeusuarios 719246
SET valortotaldenotas 932669872
```

4. Open the project in your IDE.

5. Configure the Redis connection properties into `Redis.Config.pas` and `Redis.Cache.Service.pas`

6. Configure which cache service you want to use in FormCreate method into `Principal.View.pas`
```delphi
  {* You can choose between Redis and MemCached as a cache service *}
  //FCache := TRedisCacheService.New(TRedisConfig.New);
  FCache := TMemCachedCacheService.New(TMemCachedConfig.New);
```

7. In this application, we have a personalized ListBox to present the NFe's. You must import the file `ListBoxItem1-StyleNFeNegrito.style`, which are in directory `Styles` (inside project directory) into [StyleBook1](http://docwiki.embarcadero.com/Libraries/Tokyo/en/FMX.Controls.TStyleBook) component, in PrincipalView ([see more](http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Customizing_FireMonkey_Applications_with_Styles)).

## Run

You can modify `Build configurations` to **Debug** or **Release**. And use the shortcut <kbd>SHIFT</kbd>+<kbd>F9</kbd> to build application and <kbd>F9</kbd> to run with debugging.

## Notes
### Redis
* You can use Redis in [RedisLabs](https://redislabs.com/redis-enterprise-cloud/pricing/) as a cloud service. They provide you a dedicated database for free, with a memory size with up `30MB` and with up to 30 connections concurrent
* You can use a Docker Image. For non-production uses, in this case, a simple test, I recommend  the Alpine version. I believe that is one of the lightest version, collaborating in the initialization of the container. Use the command [docker pull redis:6.0.5-alpine](https://hub.docker.com/layers/redis/library/redis/6.0.5-alpine/images/sha256-5d49b9e41e41538c64db8a8de542dc885c00b43bc6ccd4e7db1a707f2d5bfd2f?context=explore)
* **ATTENTION**: For windows installation read [this article](https://redislabs.com/ebook/appendix-a/a-3-installing-on-windows/a-3-1-drawbacks-of-redis-on-windows/)

### Delphi
If you do not have Delphi, you can do download and use [Delphi-CE](https://www.embarcadero.com/products/delphi/starter/free-download). 

## Acknowledgements

* [Thulio Bittencourt](https://github.com/bittencourtthulio) - Maintainer of the Thulio Bittencourt channel on Youtube, where he passes on much of his knowledge in his videos for free, talking about UI&UX and many other topics such as clean code, NoSQL, high-performance servers and how to make your business go high.
* [Mário Guedes](https://github.com/jmarioguedes) (What Mario? haha) - Known as the great software artisan, he works as an architect of high-performance solutions. He helped me with his lectures (TDC2018) and examples on Github, showing the power of Redis
* [Alan Franco](https://github.com/alandep) - Thanks for reactive programming tips
## License
[MIT](https://choosealicense.com/licenses/mit/)