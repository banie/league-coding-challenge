# league-coding-challenge

## Some notes:
- The talent screen Titi Odukoya that interviewed told me that the team prefers using UIkit, and so that's what I chose to use as well rather than SwiftUI.

- Note that I'm using the VIPER architecture pattern while adhering to SOLID principles. I am missing the Router part, but it's only one screen that is the default main one, and I didn't have time to tinker with it more. Btw, this is just a choice, I also don't mind MVVM or MVP.

- I'm using the SDWebImage since it's got prepackaged with the project, it's useful to download and manage the avatars right of the box.

- Similarly with Alamofire in order to make network requests. Otherwise I would've rather use URLSessions giveb by Apple.

- XCode got updated to 14.3, and as a result I had to update the min deployable version of the pods into 11.0 from 8.0, otherwise it won't run.

- I prefer using the given system colors when there's no specific design guidance in order to take care of things like DarkMode. By using system background, system label color, etc, then dark mode is taken care of automatically.

- Similarly for fonts, I believe it's better to system preference values like headline, title, and body TextStyles. Then we can set dynamic font sizing, and this way user can increase/decrease the font size from settings and the app will update automatically while preserving the intended font size ratio. 

- Note that I'm using core data to save the posts and users objects. So if network fetch fails for whatever reason, like lost connection, it will still show the previous saved posts.

- I added some unit tests covering the interactors, presenter, and the table cell. I would like to add more tests to cover everything but I'm running out of time.

- Note the project should run as is in simulator, if not then maybe do "pod init" or "pod update" first
