/**
 *  * Copyright (c) 2013 Pedro Enrique
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

package ti.table;

import java.util.ArrayList;
import java.util.HashMap;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.util.TiUIHelper;
import org.appcelerator.titanium.view.TiUIView;

import ti.table.adapters.AdapterSubtitle;
import ti.table.adapters.AdapterTitle;
import ti.table.adapters.MainAdapter;
import ti.table.helper.RHelper;
import ti.table.helper.TableConstants;

import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.RelativeLayout;

public class TableView extends TiUIView implements 
	OnItemClickListener, 
	TextWatcher, 
	OnClickListener, 
	OnFocusChangeListener
{

	private ListView tableView = null;
	private EditText searchBar = null;
	private ImageButton cancelButton = null;
	private MainAdapter adapter = null;
	private ArrayList<HashMap<String, Object>> data = null;
	private TiViewProxy tiProxy = null;
	private Context context = null;
	private int type = 0;
	
	public TableView(TiViewProxy _proxy) {
		super (_proxy);
		tiProxy = _proxy;
		context = tiProxy.getActivity().getApplicationContext();
		
		LayoutInflater inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		RelativeLayout mainView = (RelativeLayout) inflater.inflate(RHelper.getLayout("tableview"), null);
		
		tableView = (ListView) mainView.findViewById(RHelper.getId("table_view"));
		tableView.setOnItemClickListener(this);

		cancelButton = (ImageButton) mainView.findViewById(RHelper.getId("cancel_button"));
		cancelButton.setOnClickListener(this);
		
		searchBar = (EditText) mainView.findViewById(RHelper.getId("search_bar"));		
		searchBar.setImeOptions(EditorInfo.IME_ACTION_DONE);
		searchBar.addTextChangedListener(this);
		searchBar.setOnFocusChangeListener(this);
		setNativeView(mainView);		
	}
	
	public void setType(int _type) {
		type = _type;
	}
	
	@SuppressWarnings("unchecked")
	public void setData(Object[] _data) {
		data = new ArrayList<HashMap<String,Object>>();
		
		for(int i = 0, len = _data.length; i < len; i++) {
			data.add((HashMap<String, Object>)_data[i]);
		}
				
		if(tiProxy.hasProperty(TableConstants.PROPERTY_TYPE)) {
			type = (Integer)tiProxy.getProperty(TableConstants.PROPERTY_TYPE);
		}
		
		if(type == TableModule.TITLE_ONLY)  {
			adapter = new AdapterTitle(data, context, tiProxy);
		} else if(type == TableModule.SUBTITLE) {
			adapter = new AdapterSubtitle(data, context, tiProxy);
		}
		
		tableView.setAdapter(adapter);
	}

	@Override
	public void processProperties(KrollDict dict) {
		if (dict.containsKey(TableConstants.PROPERTY_TYPE)) {
			type = dict.getInt(TableConstants.PROPERTY_TYPE);
		}
		if (dict.containsKey(TableConstants.PROPERTY_DATA)) {
			Object o = dict.get(TableConstants.PROPERTY_DATA);
			if (o != null && o instanceof Object[]) {
				setData((Object[]) o);
				dict.remove(TableConstants.PROPERTY_DATA);
			}
		}
		super.processProperties(dict);
	}

	@Override
	public void onItemClick(AdapterView<?> _adapater, View row, int index, long dontknow) {
		TiUIHelper.showSoftKeyboard(nativeView, false);
		
		if (tiProxy.hasListeners(TableConstants.EVENT_CLICK)) {
			KrollDict dict = new KrollDict();
			dict.put(TableConstants.PROPERTY_ROW_DATA, adapter.getData().get(index));
			dict.put(TableConstants.EVENT_PROPERTY_INDEX, index);
			tiProxy.fireEvent(TableConstants.EVENT_CLICK, dict);
		}
	}
	
	@Override
	public void afterTextChanged(Editable arg0) {
	}
	
	@Override
	public void beforeTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
	}
	
	@Override
	public void onTextChanged(CharSequence sequence, int start, int before, int count) {
		
		if(count == 0) {
			adapter.setData(data);
			return;
		}
		ArrayList<HashMap<String, Object>> newData = new ArrayList<HashMap<String,Object>>();

		for(int i = 0, len = data.size(); i < len; i++) {
			HashMap<String, Object> obj = data.get(i);
			if(obj.containsKey(TableConstants.PROPERTY_TITLE)) {
				if(obj.get(TableConstants.PROPERTY_TITLE).toString().toLowerCase().contains(sequence.toString().toLowerCase())) {
					newData.add(obj);
					continue;
				}
			}
			if(type == TableModule.SUBTITLE && obj.containsKey(TableConstants.PROPERTY_SUBTITLE)) {
				if(obj.get(TableConstants.PROPERTY_SUBTITLE).toString().toLowerCase().contains(sequence.toString().toLowerCase())) {
					newData.add(obj);
					continue;
				}
			}

		}
		adapter.setData(newData);
		tableView.invalidate();
	}

	@Override
	public void onFocusChange(View v, boolean hasFocus) {
		if(!hasFocus) {
			TiUIHelper.showSoftKeyboard(nativeView, false);
		}
		super.onFocusChange(v, hasFocus);
	}
	
	@Override
	public void onClick(View button) {
		searchBar.setText("");
	}
}