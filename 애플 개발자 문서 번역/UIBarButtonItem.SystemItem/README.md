# UIBarButtonItem.SystemItem
>  바 버튼 아이템에 대한 시스템 제공 이미지를 정의한다.


&nbsp;      
## Topics
### Constants
* `case done`
    * 시스템 완료 버튼. 지역화 된다.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonSystemItemDone_2x_faf853e2-1569-42df-a353-2217d5e5798f.png)
* `case cancel`
    * 시스템 취소 버튼. 지역화 된다.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarSystemItemCancel_2x_193aca68-8a37-445f-9300-df5ed61eaebe.png)
* `case edit`
    * 시스템 편집 버튼. 지역화 된다.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarSystemItemEdit_2x_8e760150-573b-4d16-bc0f-a0a98f59d25f.png)
* `case save`
    * 시스템 저장 버튼. 지역화 된다.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonSystemItemSave_2x_74e89675-76ec-42fa-b140-43617c605754.png)
* `case add`
    * 플러스 기호 아이콘이 포함된 시스템 플러스 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonAdd_2x_06ceba7f-f447-4e80-8387-99ef94745a90.png)
* `case flexibleSpace`
    * 다른 아이템 사이에 추가할 빈 공간이다. 빈 공간은 다른 아이템간에 균등하게 분배된다. 이 값을 설정하면 다른 아이템 프로퍼티는 무시된다.
* `case fixedSpace`
    * 다른 아이템 사이에 추가할 빈 공간이다. 이 값이 설정되면 width 프로퍼티만 사용된다.
* `case compose`
    * 시스템 작성 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonCompose_2x_cd7e6340-c981-4dc4-85ae-63ae5a64ccfc.png)
* `case reply`
    * 시스템 회신 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonReply_2x_ae1b2646-b99b-4828-bb5b-ca4e689169fa.png)
* `case action`
    * 시스템 동작 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonAction_2x_823aa32f-53ef-4c8a-9487-0aee63782087.png)
* `case organize`
    * 시스템 구성 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonOrganize_2x_0e37fc64-4d56-4d6b-85a2-7da5483d1f27.png)
* `case bookmarks`
    * 시스템 북마크 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonBookmarks_2x_01ffb6a4-22bd-48ac-a7d4-46133e1de9a4.png)
* `case search`
    * 시스템 검색 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonSearch_2x_e1da736a-4199-489d-b258-43c6717ac2c1.png)
* `case refresh`
    * 시스템 새로고침 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonRefresh_2x_932a1c8a-1981-4b5d-8166-d2ffcabdff01.png)
* `case stop`
    * 시스템 중지 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonStop_2x_b0334ee9-f617-46c0-8f05-6a6fd6f223f7.png)
* `case camera`
    * 시스템 카메라 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonCamera_2x_87a3ae25-6025-4bd9-8060-8221cafa61ce.png)
* `case trash`
    * 시스템 휴지통 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonTrash_2x_3e31cb62-8df3-4364-86d8-6b676bcbb38b.png)
* `case play`
    * 시스템 재생 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonPlay_2x_b0a5a395-c1f7-43e3-851f-9f929cba2176.png)
* `case pause`
    * 시스템 일시 정지 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonPause_2x_c5ad205a-c25f-45fd-8ee8-528b562957ca.png)
* `case rewind`
    * 시스템 되감기 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonRewind_2x_ddce5dd2-5072-42e4-bf4a-030b914b5584.png)
* `case fastForward`
    * 시스템 빨리 감기 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonFastForward_2x_aee52cd9-4b46-4144-8ccb-b280fa9b3147.png)
* `case undo`
    * 시스템 실행 취소 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonSystemItemUndo_2x_bb2fa0eb-a241-47e1-9818-bc54370fe33c.png)
* `case redo`
    * 시스템 재실행 버튼.
    * ![](https://docs-assets.developer.apple.com/published/1b2c2dc9eb/UIBarButtonSystemItemRedo_2x_87125ce6-1986-4c7f-9ba8-a7607cf16cc9.png)
    

&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIBarButtonItem.SystemItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem/systemitem)
