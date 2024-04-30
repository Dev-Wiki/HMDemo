
export class CommonRes {
  static readonly IC_CHEVRON_LEFT = "ic_chevron_left";
  static readonly IC_CHEVRON_RIGHT = "ic_chevron_right";

  private constructor() {
  }

  public static getIconRefresh(): Resource {
    return $r("app.media.ic_refresh");
  }

  public static getIconChevronLeft(): Resource {
    return $r("app.media.ic_chevron_left");
  }

  public static getIconChevronRight(): Resource {
    return $r("app.media.ic_chevron_right");
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