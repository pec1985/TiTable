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
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.view.TiDrawableReference;

import ti.table.TableModule;
import ti.table.helper.RHelper;
import ti.table.helper.TableConstants;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class AdapterTitle extends MainAdapter 
{
	private class TableViewRow
    {
		RelativeLayout backgroundView;
		TextView rowTitle;
    	ImageView leftImage;
    	ImageView rightImage;
    }

	
	public AdapterTitle(ArrayList<HashMap<String,Object>> _data, Context _context, TiViewProxy _proxy) {
		super(_data, _context, _proxy);
	}	


	@Override
	public View getView(int _position, View convertView, ViewGroup parent) {
		
        View row = convertView;
        TableViewRow holder = null;
        
		if(row == null) {
            row = inflater.inflate(RHelper.getLayout("title"), null);
            holder = new TableViewRow();
            holder.backgroundView = (RelativeLayout)row.findViewById(RHelper.getId("main_view"));
            holder.rowTitle = (TextView)row.findViewById(RHelper.getId("row_title"));
            holder.leftImage = (ImageView)row.findViewById(RHelper.getId("leftImage"));
            holder.rightImage = (ImageView)row.findViewById(RHelper.getId("rightImage"));
            row.setTag(holder);
        } else {
            holder = (TableViewRow)row.getTag();
        }
        
		HashMap<String, Object> currentDict = data.get(_position);
		
		if(currentDict.containsKey(TableConstants.PROPERTY_TITLE)) {
			holder.rowTitle.setText(currentDict.get(TableConstants.PROPERTY_TITLE).toString());
		} else {
			holder.rowTitle.setText("");
		}
		
		if(currentDict.containsKey(TableConstants.PROPERTY_TITLE_COLOR)) {
			holder.rowTitle.setTextColor(TiConvert.toColor(currentDict, TableConstants.PROPERTY_TITLE_COLOR));
		} else if(currentDict.containsKey(TableConstants.PROPERTY_COLOR)) {
			holder.rowTitle.setTextColor(TiConvert.toColor(currentDict, TableConstants.PROPERTY_COLOR));
		} else {
			holder.rowTitle.setTextColor(Color.DKGRAY);
		}

		if(currentDict.containsKey(TableConstants.PROPERTY_BACKGROUND_COLOR)) {
			holder.backgroundView.setBackgroundDrawable(null);
			holder.backgroundView.setBackgroundColor(TiConvert.toColor(currentDict, TableConstants.PROPERTY_BACKGROUND_COLOR));
		} else if(currentDict.containsKey(TableConstants.PROPERTY_BACKGROUND_IMAGE)) {
			TiDrawableReference source = TableModule.makeImageSource(proxy, currentDict.get(TableConstants.PROPERTY_BACKGROUND_IMAGE));
			holder.backgroundView.setBackgroundColor(Color.TRANSPARENT);
			holder.backgroundView.setBackgroundDrawable(source.getDrawable());
		} else {
			holder.backgroundView.setBackgroundColor(Color.TRANSPARENT);
			holder.backgroundView.setBackgroundDrawable(null);
		}

		if(currentDict.containsKey(TableConstants.PROPERTY_RIGHT_IMAGE)) {
			TiDrawableReference source = TableModule.makeImageSource(proxy, currentDict.get(TableConstants.PROPERTY_RIGHT_IMAGE));
			holder.rightImage.setImageBitmap(source.getBitmap());			
		} else
		if(currentDict.containsKey(TableConstants.PROPERTY_HAS_CHILD) && TiConvert.toBoolean(currentDict, TableConstants.PROPERTY_HAS_CHILD)) {
			holder.rightImage.setImageResource(RHelper.getDrawable(TableConstants.DRAWABLE_CHEVRON));
		} else {
			holder.rightImage.setImageBitmap(null);
		}
		
		if(currentDict.containsKey(TableConstants.PROPERTY_LEFT_IMAGE)) {
			TiDrawableReference source = TableModule.makeImageSource(proxy, currentDict.get(TableConstants.PROPERTY_LEFT_IMAGE));
			holder.leftImage.setImageBitmap(source.getBitmap());
		} else {
			holder.leftImage.setImageBitmap(null);
		}

		return row;
	}

}