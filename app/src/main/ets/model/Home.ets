
export class HomeItem {
  /**
   * 列表项名称
   */
  name: ResourceStr = '';
  /**
   * 列表项要打开的页面路径
   */
  page?: string;
}

export class HomeItemGroup {
  /**
   * 分组的名称
   */
  name: ResourceStr = '';
  /**
   * 分组图标
   */
  icon?: Resource;
  /**
   * 分组的Item列表
   */
  items: HomeItem[] = [];
}