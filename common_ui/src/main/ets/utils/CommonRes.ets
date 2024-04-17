
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

  public static getIconEyeOn(): Resource {
    return $r("app.media.ic_eye_on");
  }

  public static getIconEyeOff(): Resource {
    return $r("app.media.ic_eye_off");
  }

  public static getImageRes(resName: string): Resource {
    return $r(`app.media.${resName}`);
  }
}

export class CommonMediaName {
  private constructor() {
  }
  static readonly IcEyeOn = "ic_eye_on";
  static readonly IcEyeOff = "ic_eye_ff";
}