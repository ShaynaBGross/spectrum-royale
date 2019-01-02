package com.unhurdle.spectrum
{

  import org.apache.royale.html.beads.plugin.ModalDisplay;
  import org.apache.royale.html.beads.plugin.ModalOverlay;
  import org.apache.royale.utils.CSSUtils;

  COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  
  public class Alert extends SpectrumBase
  
  {
//   <div class="spectrum-Alert spectrum-Alert--error"> -- closable --
//   <svg class="spectrum-Icon spectrum-UIIcon-AlertMedium spectrum-Alert-icon" focusable="false" aria-hidden="true"> --
//   <use xlink:href="#spectrum-css-icon-AlertMedium" /> --
//   </svg>
//   <div class="spectrum-Alert-header">Incorrect Payment Information - Error</div> --
//   <div class="spectrum-Alert-content">This is an alert.</div>
//   <div class="spectrum-Alert-footer">
//   <button class="spectrum-Button spectrum-Button--primary spectrum-Button--quiet">Close</button>
//   </div>
// </div>
    public function Alert(){
      super();
      typeNames = "spectrum-Alert";
      visible = false;
      modal = new ModalDisplay();
      addBead(modal);
    }

    private var _overlayColor:String;

    /**
     * The color value of the overlay (default black)
     * Either overlayColor or overlayAlpha needs to be set for an overlay to show at all.
     * 
     */
    public function get overlayColor():String
    {
    	return _overlayColor;
    }

    public function set overlayColor(value:String):void
    {
    	_overlayColor = value;
      getOverlayBead().color = CSSUtils.toColor(value);
    }
    private var _overlayAlpha:Number;

    /**
     * The alpha of the overlay in a value of 0 through 1 (default 0.5).
     * Either overlayColor or overlayAlpha needs to be set for an overlay to show at all.
     * 
     */
    public function get overlayAlpha():Number
    {
    	return _overlayAlpha;
    }

    public function set overlayAlpha(value:Number):void
    {
    	_overlayAlpha = value;
      getOverlayBead().alpha = value;
    }

    private var modal:ModalDisplay;
    
    private function getOverlayBead():ModalOverlay{
      if(!_overlayBead){
        _overlayBead = new ModalOverlay();
        addBead(_overlayBead);
      }
      return _overlayBead
    }
    private var _overlayBead:ModalOverlay;

    private var _closeText:String;

    public function get closeText():String{
      return _closeText;
    }

    public function set closeText(value:String):void{
      if(value != _closeText){
        setCloseButton(value);
      }
      _closeText = value;
    }

    private var _header:String;

    public function get header():String
    {
      return _header;
    }

    public function set header(value:String):void
    {
      _header = value;
    }

    private var _content:String;

    public function get content():String
    {
      return _content;
    }

    public function set content(value:String):void
    {
      _content = value;
    }

    COMPILE::JS
    private var headerNode:Text;

    COMPILE::SWF
    private var headerNode:Object;
    
    COMPILE::JS
    private var contentNode:Text;

    COMPILE::SWF
    private var contentNode:Object;

    COMPILE::JS
    private var button:HTMLButtonElement; //use the spectrum button? //eventually
    
    COMPILE::JS
    private var icon:SVGElement;

    COMPILE::SWF
    private var icon:Object;

    COMPILE::JS
    private var useElement:SVGUseElement;

    COMPILE::SWF
    private var useElement:Object;
    
    COMPILE::JS
    private function createIcon(status:String):void{
      var type:String;

      switch(status){
        case Alert.ERROR:
          type = "Alert";
          break;
        case Alert.HELP:
          type = "Help";
          break;
        case Alert.INFO:
          type = "Info";
          break;
        case Alert.SUCCESS:
          type = "Success";
          break;
        case Alert.WARNING:
          type = "Alert";
          break;
      }
      if(!type){
        type == "Alert";
      }

      if(icon){
        icon.className = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Alert-icon";
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-' + type + 'Medium');
      } else {
        icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
        icon.className = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Alert-icon";
        useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-' + type + 'Medium');
        icon.appendChild(useElement);
        element.insertBefore(icon, element.childNodes[0] || null);
      }

    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');


      var headerElem:HTMLDivElement = newElement("div") as HTMLDivElement;
      headerElem.className = "spectrum-Alert-header";
      headerNode = newTextNode(header);
      headerElem.appendChild(headerNode);
      elem.appendChild(headerElem);

      var contentElem:HTMLDivElement = newElement("div") as HTMLDivElement;
      contentElem.className = "spectrum-Alert-content";
      contentNode = newTextNode(content);
      contentElem.appendChild(contentNode);
      elem.appendChild(contentElem);

      return elem;
    }

    COMPILE::JS
    private var closeButtonNode:Text;

    COMPILE::SWF
    private var closeButtonNode:Object;

    private function setCloseButton(value:String):void{
      COMPILE::JS
      {
        if(!closeButtonNode){
          var footer:HTMLElement = newElement('div');
          footer.className = "spectrum-Alert-footer";
          button = newElement("button") as HTMLButtonElement;
          button.className = "spectrum-Button spectrum-Button--primary spectrum-Button--quiet";
          closeButtonNode = newTextNode(value);
          button.appendChild(closeButtonNode);
          footer.appendChild(button);
          element.appendChild(footer);
        } else {
          closeButtonNode.nodeValue = value;
        }
      }

    }
    
    public function show():void{
      visible = true;
      modal.show(Application.current);
		}
    
    public static const CLOSABLE:String = "error";
    public static const ERROR:String = "error";
    public static const HELP:String = "help";
    public static const INFO:String = "info";
    public static const SUCCESS:String = "success";
    public static const WARNING:String = "warning";
    
    private var _status:String;

    public function get status():String
    {
    	return _status;
    }
    
    public function set status(value:String):void
    {
      COMPILE::JS
      {
        if(value != _status){
          switch(value){
            case Alert.CLOSABLE:
            case Alert.ERROR:
            case Alert.HELP:
            case Alert.INFO:
            case Alert.SUCCESS:
            case Alert.WARNING:
              break;
            default:
              throw new Error("Invalid status: " + value);
          }
          var oldStatus:String = valueToCSS(_status);
          var newStatus:String = valueToCSS(value);
          toggle(newStatus, true);
          toggle(oldStatus, false);
          createIcon(value);
        }
      }
      _status = value;
    }
    COMPILE::JS
    private function valueToCSS(status:String):String{
      return "spectrum-Alert--" + status;
    }   
  }
}