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

package ti.table.adapters;

import java.util.ArrayList;
import java.util.HashMap;

import org.appcelerator.titanium.proxy.TiViewProxy;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

public class MainAdapter extends BaseAdapter 
{

	protected Context context;
	protected ArrayList<HashMap<String,Object>> data;
	protected LayoutInflater inflater;
	protected TiViewProxy proxy;
        
	public MainAdapter(ArrayList<HashMap<String,Object>> _data, Context _context, TiViewProxy _proxy) {
		proxy = _proxy;
		data = _data;
		context = _context;
        inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	@Override
	public int getCount() {
		return data.size();
	}

	@Override
	public Object getItem(int position) {
		return position;
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public ArrayList<HashMap<String,Object>> getData() {
		return data;
	}
	
	public void setData(ArrayList<HashMap<String,Object>> _data) {
		data = _data;
		notifyDataSetChanged();
	}
	
	@Override
	public View getView(int _position, View convertView, ViewGroup parent) {
		// for subclass
		return convertView;
	}

}