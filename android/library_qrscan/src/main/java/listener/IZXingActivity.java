package listener;

import android.app.Activity;
import android.graphics.Rect;
import android.os.Handler;

import com.google.zxing.Result;


/**
 * Created by ryan on 18/4/4.
 */

public interface IZXingActivity
{
    void handleDecode(Result result);

    Rect getCropRect();

    Activity getActivity();

    Handler getHandler();
}
