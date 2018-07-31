package com.ict.util;

public class ImageState {
    @Override
  public String toString() {
          // TODO Auto-generated method stub
          return "["+left+","+top+","+right+","+bottom+"] ("+(right-left)+","+(bottom-top)+")" ;//super.toString();
  }
  private float left;
    public float getLeft() {
          return left;
  }
  public void setLeft(float left) {
          this.left = left;
  }
  public float getTop() {
          return top;
  }
  public void setTop(float top) {
          this.top = top;
  }
  public float getRight() {
          return right;
  }
  public void setRight(float right) {
          this.right = right;
  }
  public float getBottom() {
          return bottom;
  }
  public void setBottom(float bottom) {
          this.bottom = bottom;
  }
  private float top;
    private float right;
    private float bottom;
  } //然后获取ImageView的matrix，根据matrix的getValues获得3x3矩阵。