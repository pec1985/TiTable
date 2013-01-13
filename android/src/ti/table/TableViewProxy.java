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

import org.appcelerator.kroll.annotations.Kroll;

import org.appcelerator.titanium.TiContext;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiUIView;
import android.app.Activity;
	
@Kroll.proxy(creatableInModule=TableModule.class)

public class TableViewProxy extends TiViewProxy
{
	
	public TableViewProxy() {
		super();
	}
	
	public TableViewProxy(TiContext tiContext) {
		this();
	}

	private TableView theView = null;
	
	public TableView getView(){
		if(theView == null) {
			theView = new TableView(this);
		}
		return theView;
	}
	
	@Override
	public TiUIView createView(Activity activity) {
		return getView();
	}

	@Kroll.method @Kroll.setProperty
	public void setData(Object _data) {
		getView().setData((Object[] )_data);
	}
	
	@Kroll.method @Kroll.setProperty
	public void setType(int _type) {
		getView().setType(_type);
	}
}
