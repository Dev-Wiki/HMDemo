
export class CommonRes {
  private constructor() {
  }

  public static getIconRefresh(): Resource {
    return $r("app.media.ic_refresh");
  }

  public static getIconBack(): Resource {
    return $r("app.media.ic_chevron_left");
  }

  public static getIconClose(): Resource {
    return $r("app.media.ic_close");
  }
}