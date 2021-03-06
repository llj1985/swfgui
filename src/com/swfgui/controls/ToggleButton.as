package com.swfgui.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="change", type="flash.events.Event")]
	
	public class ToggleButton extends Button
	{
		//STATE_*selected = STATE_* + STATE_DIFF
		private const STATE_DIFF:int = 4;
//		protected const STATE_UPselected:int = STATE_UP + STATE_DIFF;
//		protected const STATE_OVERselected:int = STATE_OVER + STATE_DIFF;
//		protected const STATE_DOWNselected:int = STATE_DOWN + STATE_DIFF;
//		protected const STATE_DISABLEDselected:int = STATE_DISABLED + STATE_DIFF;

		/**
		 * 
		 * @param view 通常来说，应该是有8帧的mc，前4帧是未选择时候的4种状态，
		 * 后4帧是选中以后的4种状态。也可以是4帧的mc，就默认把down当作选中时候的状态。
		 */
		public function ToggleButton(viewSource:Object=null)
		{
			super(viewSource);
		}
		
		override public function get className():String
		{
			return "ToggleButton";
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			selected = false;			
			
			this.addEventListener(MouseEvent.CLICK, onMouseClk);
		}
		
		override public function dispose():void
		{
			this.removeEventListener(MouseEvent.CLICK, onMouseClk);
			
			super.dispose();
		}
		
		protected function onMouseClk(e:MouseEvent):void
		{
			this.selected = !this.selected;
		}

		override public function set selected(value:Boolean):void
		{
			if (selected == value)
			{
				return;
			}

			super.selected = value;
			updateState();//invalidateProperties();
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		override protected function updateState():void
		{
			if(!viewMC)
			{
				return;
			}
			
			if(selected)
			{
				//view是4帧的mc，而不是8帧的mc
				if(viewMC.totalFrames <= STATE_DISABLED)
				{
					//拿down状态替代选中状态
					viewMC.gotoAndStop(state == STATE_UP ? STATE_DOWN : state);
				}
				else
				{
					viewMC.gotoAndStop(state + STATE_DIFF);
				}
			}
			else
			{
				super.updateState();
			}
		}
	}
}