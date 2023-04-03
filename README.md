# league-coding-challenge

## Some notes:
- The talent screen Titi Odukoya that interviewed told me that the team prefers using UIkit, and so that's what I chose to use as well rather than SwiftUI.

- I'm using the SDWebImage since it's got prepackaged with the project, it's useful to download and manage the avatars right of the box.

- Similarly with Alamofire in order to make network requests. Otherwise I would've rather use URLSessions giveb by Apple.

- XCode got updated to 14.3, and as a result I had to update the min deployable version of the pods into 11.0 from 8.0, otherwise it won't run.

- I prefer using the given system colors when there's no specific design guidance in order to take care of things like DarkMode. By using system background, system label color, etc, then dark mode is taken care of automatically.

- Similarly for fonts, I believe it's better to system preference values like headline, title, and body TextStyles. Then we can set dynamic font sizing, and this way user can increase/decrease the font size from settings and the app will update automatically while preserving the intended font size ratio. 
