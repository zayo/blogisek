Blogísek Míši a Níši
-----------------------------
This project was created as a final task for Ruby, lectured on Masaryk University Brno.<br />
Briefly, it is an extended Blog platform.

Authors of this project:
-----------------------------
Stanislav Nedbalek (Uco: 374524) <br />
Michal Navratil (Uco: 448292)

Url
----------
http://immense-badlands-8590.herokuapp.com/


Superuser credentials
----------
login: admin@admin.com<br />
passw: adminadmin

========================================================================================================================

More complexly
------------------
There are 3 roles, with different abilities:

Guest:(not sign in)
- See some posts
- Can comment on posts and comments
- Filter by tags (only tags from not private posts)

User:(sign in)
- Can add new post
- Can update own posts
- Can make post private (Guest can't see)
- Can disable commenting on post (Not destroy existing comments)
- Can request that all comments (except own) need to be approved by author of post.
- Can likes, or dislikes comments
- Can approve or disapprove comments (Approvals are then shown in waiting comments, or in approval section)
- Filter by tags (All of them)

Superuser:(too super to be just a normal user)
- Can acts as every user, except add content by their name.
- He also can't approve/disapprove comment, cause he can delete it instead.

© urvi <3 nislav 2016