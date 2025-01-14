package com.tencent.liteav.demo.view.component;

import android.content.Context;
import android.text.TextUtils;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.appcompat.widget.Toolbar;

import com.tencent.cloud.tuikit.engine.room.TUIRoomDefine;
import com.tencent.liteav.demo.R;
import com.tencent.liteav.demo.viewmodel.CreateRoomViewModel;
import com.tencent.qcloud.tuicore.TUILogin;
import com.tencent.qcloud.tuicore.interfaces.TUICallback;
import com.tencent.qcloud.tuicore.util.ToastUtil;

import java.util.ArrayList;

public class CreateRoomView extends RelativeLayout
        implements View.OnClickListener {
    private Context             mContext;
    private Toolbar             mToolbar;
    private TextView            mTextCreateRoom;
    
    private TextView            mTextUserName;
    private TextView            mTextRoomType;
    private LinearLayout        mLayoutSettingContainer;
    private RoomTypeSelectView  mRoomTypeDialog;
    private CreateRoomViewModel mViewModel;

    private TUICallback mFinishCallback;

    private String mRoomId;

    public CreateRoomView(Context context) {
        super(context);
        View.inflate(context, R.layout.app_view_create_room, this);
        mContext = context;
        mViewModel = new CreateRoomViewModel(mContext);
        initView();
        initData();
    }

    public void setFinishCallback(TUICallback finishCallback) {
        mFinishCallback = finishCallback;
    }

    private void initData() {
        String userName = TUILogin.getNickName();
        mTextUserName.setText(userName);
        mViewModel.getRoomId(new CreateRoomViewModel.GetRoomIdCallback() {
            @Override
            public void onGetRoomId(String roomId) {
                mRoomId = roomId;
            }
        });
    }

    private void initView() {
        mToolbar = findViewById(R.id.toolbar);
        mTextCreateRoom = findViewById(R.id.tv_create);
        mTextUserName = findViewById(R.id.tv_user_name);
        mTextRoomType = findViewById(R.id.tv_room_type);
        mLayoutSettingContainer = findViewById(R.id.ll_setting_container);
        mRoomTypeDialog = new RoomTypeSelectView(mContext);
        mRoomTypeDialog.setSeatEnableCallback(new RoomTypeSelectView.SeatEnableCallback() {
            @Override
            public void onSeatEnableChanged(boolean enable) {
                mViewModel.setSeatEnable(enable);
                int resId = enable ? R.string.app_room_raise_hand : R.string.app_room_free_speech;
                mTextRoomType.setText(resId);
            }
        });

        mTextRoomType.setOnClickListener(this);
        mTextCreateRoom.setOnClickListener(this);
        mToolbar.setNavigationOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mFinishCallback != null) {
                    mFinishCallback.onSuccess();
                }
            }
        });

        ArrayList<SwitchSettingItem> settingItemList = mViewModel.createSwitchSettingItemList();
        int size = settingItemList.size();
        for (int i = 0; i < size; i++) {
            SwitchSettingItem item = settingItemList.get(i);
            if (i == size - 1) {
                item.hideBottomLine();
            }
            mLayoutSettingContainer.addView(item.getView());
        }
    }

    @Override
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
    }

    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.tv_room_type) {
            if (mRoomTypeDialog == null) {
                mRoomTypeDialog = new RoomTypeSelectView(mContext);
            }
            mRoomTypeDialog.show();
        } else if (view.getId() == R.id.tv_create) {
            if (TextUtils.isEmpty(mRoomId)) {
                ToastUtil.toastShortMessage(mContext.getString(R.string.app_tip_creating_room_id));
                return;
            }
            mViewModel.createRoom(mRoomId);
            mTextCreateRoom.setClickable(false);
        }
    }
}
