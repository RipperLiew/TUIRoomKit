package com.tencent.liteav.demo.view.component;

import android.content.Context;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.appcompat.widget.Toolbar;

import com.tencent.liteav.demo.R;
import com.tencent.liteav.demo.viewmodel.EnterRoomViewModel;
import com.tencent.qcloud.tuicore.TUILogin;
import com.tencent.qcloud.tuicore.interfaces.TUICallback;

import java.util.ArrayList;

public class EnterRoomView extends RelativeLayout {

    private Context            mContext;
    private Toolbar            mToolbar;
    private TextView           mTextEnterRoom;
    private TextView           mTextUserName;
    private EditText           mTextRoomId;
    private LinearLayout       mSettingContainer;
    private EnterRoomViewModel mViewModel;
    private TUICallback        mFinishCallback;


    public EnterRoomView(Context context) {
        super(context);
        View.inflate(context, R.layout.app_view_enter_room, this);
        mContext = context;
        mViewModel = new EnterRoomViewModel(mContext);
        initView();
    }

    public void setFinishCallback(TUICallback finishCallback) {
        mFinishCallback = finishCallback;
    }

    private void initView() {
        mToolbar = findViewById(R.id.toolbar);
        mTextRoomId = findViewById(R.id.et_room_id);
        mTextEnterRoom = findViewById(R.id.tv_enter);
        mSettingContainer = findViewById(R.id.ll_setting_container);
        mTextUserName = findViewById(R.id.tv_user_name);

        mTextEnterRoom.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                mTextEnterRoom.setClickable(false);
                mViewModel.enterRoom(mTextRoomId.getText().toString());
            }
        });
        mToolbar.setNavigationOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mFinishCallback != null) {
                    mFinishCallback.onSuccess();
                }
            }
        });
        mTextRoomId.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                mTextEnterRoom.setEnabled(!TextUtils.isEmpty(mTextRoomId.getText().toString()));
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        ArrayList<SwitchSettingItem> settingItemList = mViewModel.createSwitchSettingItemList();
        int size = settingItemList.size();
        for (int i = 0; i < size; i++) {
            SwitchSettingItem item = settingItemList.get(i);
            if (i == size - 1) {
                item.hideBottomLine();
            }
            mSettingContainer.addView(item.getView());
        }

        mTextUserName.setText(TUILogin.getNickName());
    }
}
