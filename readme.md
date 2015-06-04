# ![VKNewsFeed](https://github.com/DmitrJuga/VKNewsFeed/blob/master/VKNewsFeed/Images.xcassets/AppIcon.appiconset/vkdog-29@2x.png)      VK News Feed

**"VK News Feed"** - простое приложение для поиска и просмотра новостей (записей на стенах) в социальной сети [ВКонтакте](http://vk.com/). Учебный (тренировочный) проект на **Objective-C** c использованием **AFNetworking** и работой с [API VK](http://vk.com/dev/methods).

![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot1.png)
![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot2.png)

## Функционал

- Поиск новостей (записей на стенах) в ВК по произвольной строке.
- Результат поиска содержит до 30 последних новостей (от более новых к более старым).
- В списке новостей отображается информация об отправителе (имя пользователя или группы, аватар), дата и время публикации, краткий текст сообщения.
- Возможен детальный просмотр выбранной новости.
- При детальном просмотре отображается полный текст сообщения (с возможностью выделения и копирования, URL-ссылками), прикреплённые фото.
- Другие виды вложений, кроме *фото*, (например, *видео* или *аудио*) также отображаются, но не функциональны (не воспроизводятся, не открываются) и сопровождаются сообщением *"неподдерживаемый контент"*.


## Technical Information

**Networking**
- Using **AFNetworking** external framework (installed with **CocoaPods** dependency manager);
- `AFHTTPRequestOperationManager` for HTTP requests creating and response serialization;
- `AFNetworkActivityIndicatorManager` for automatically displaying network activity indicator;
- `UIImageView+AFNetworking` category for asynchronously downloading and caching images.

**VK API usage**:
- Calling VK API `newsfeed.search` method;
- Sending `extended` parameter to return search result with additional information about the user or community that placed the post;
- Using my own API-managing class `VKAPIManager` with delegate;
- Data model has two classes (`News` and `Attachemnt`) with json-responce mapping methods.

**UIKit framework usage:**
- Using 2 `UIViewController`s + `UINavigationController`;
- `UITableView`s with custom and autosizing cells;
- Different types of custom cells in one TableView;
- `UITableViewAutomaticDimension` parameter for set dynamic cell height based on content size;
- `UISearchBar` as TableView header view;
- Custom screen-blocking activity indicator;
- Auto Layout (Storyboard constraints);
- Custom `UINavigationBar` appearance tint colors.

**Extra:**
- AppIcon (image from open web sources);


## More Screenshots

![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot3.png)
![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot4.png)
![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot5.png)
![](https://github.com/DmitrJuga/VKNewsFeed/blob/master/screenshots/screenshot6.png)


## Основа проекта

Проект создан на основе моей домашней работы к урокам 7-8 по курсу **"Objective C. Уровень 2"** в [НОЧУ ДО «Школа программирования» (http://geekbrains.ru)](http://geekbrains.ru/).   
Темы, рассмотренные на данных уроках: работа с JSON, работа с сетью, работа с серверным API на примере API соц.сети VK, использование CocoaPods на примере AFNetworking, использование AFNetworking для упрощения сетевых задач.

---

### Contacts

**Дмитрий Долотенко / Dmitry Dolotenko**

Krasnodar, Russia   
Phone: +7 (918) 464-02-63   
E-mail: <dmitrjuga@gmail.com>   
Skype: d2imas

:]

