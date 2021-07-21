package com.example.paintapp;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.ImageFormat;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.YuvImage;
import android.provider.MediaStore;
import android.graphics.Color;
import android.renderscript.Allocation;
import android.renderscript.Element;
import android.renderscript.RenderScript;
import android.renderscript.ScriptIntrinsicYuvToRGB;
import android.renderscript.Type;
import android.view.WindowManager;
import android.util.DisplayMetrics;
import java.util.Arrays;

import androidx.annotation.NonNull;

import org.opencv.android.OpenCVLoader;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import org.opencv.core.Mat;
import org.opencv.core.MatOfInt;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.android.Utils;
import org.opencv.core.CvType;
import org.opencv.core.Scalar;
import org.opencv.core.Core;
import org.opencv.core.Point;
/* import org.opencv.core.Rect; */

import java.util.ArrayList;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.dev/battery";

  static {

    if (OpenCVLoader.initDebug()) {

      System.out.println("OpenCv configured successfully");

    } else {

      System.out.println("OpenCv doesn’t configured successfully");

    }

  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler((call, result) -> {
          // Note: this method is invoked on the main thread.
          if (call.method.equals("getBatteryLevel")) {
            List<byte[]> bytesList = call.argument("bytelist");
            int[] strides = call.argument("strides");
            int height = call.argument("height");
            int width = call.argument("width");
            String c = call.argument("color");
            double x = call.argument("x");
            double y = call.argument("y");
            Point p = new Point(x, y);
            try {
              byte[] data = NV21toJPEG(YUVtoNV21(bytesList, strides, width, height), width, height, 100);
              Bitmap bitmapRaw = BitmapFactory.decodeByteArray(data, 0, data.length);

              Matrix matrix = new Matrix();
              matrix.postRotate(90);
              Bitmap finalbitmap = Bitmap.createBitmap(bitmapRaw, 0, 0, bitmapRaw.getWidth(), bitmapRaw.getHeight(),
                  matrix, true);

              finalbitmap = detectEdges(finalbitmap, c, p);

              ByteArrayOutputStream outputStreamCompressed = new ByteArrayOutputStream();
              finalbitmap.compress(Bitmap.CompressFormat.JPEG, 60, outputStreamCompressed);

              result.success(outputStreamCompressed.toByteArray());
              outputStreamCompressed.close();
              data = null;
            } catch (IOException e) {
              e.printStackTrace();
            }

          } else {
            result.notImplemented();
          }
        });
  }

  private Bitmap detectEdges(Bitmap bitmap, String c, Point p) {
    double cannyMinThres = 30.0;
    double ratio = 2.5;
    Mat mRgbMat = new Mat();
    Utils.bitmapToMat(bitmap, mRgbMat);

    Imgproc.cvtColor(mRgbMat, mRgbMat, Imgproc.COLOR_RGBA2RGB);
    Mat mask = new Mat(new Size(mRgbMat.width() / 8.0, mRgbMat.height() / 8.0), CvType.CV_8UC1, new Scalar(0.0));

    Mat img = new Mat();
    mRgbMat.copyTo(img);

    Mat mGreyScaleMat = new Mat();
    Imgproc.cvtColor(mRgbMat, mGreyScaleMat, Imgproc.COLOR_RGB2GRAY, 3);
    Imgproc.medianBlur(mGreyScaleMat, mGreyScaleMat, 3);

    Mat cannyGreyMat = new Mat();
    Imgproc.Canny(mGreyScaleMat, cannyGreyMat, cannyMinThres, cannyMinThres * ratio, 3);

    Mat hsvImage = new Mat();
    Imgproc.cvtColor(img, hsvImage, Imgproc.COLOR_RGB2HSV);

    ArrayList<Mat> list = new ArrayList<Mat>(3);
    Core.split(hsvImage, list);
    Mat sChannelMat = new Mat();
    List<Mat> listMat = new ArrayList<Mat>();
    listMat.add(list.get(1));
    // Arrays.asList(list.get(1));
    Core.merge(listMat, sChannelMat);
    Imgproc.medianBlur(sChannelMat, sChannelMat, 3);

    Mat cannyMat = new Mat();
    Imgproc.Canny(sChannelMat, cannyMat, cannyMinThres, cannyMinThres * ratio, 3);

    Core.addWeighted(cannyMat, 0.5, cannyGreyMat, 0.5, 0.0, cannyMat);
    Imgproc.dilate(cannyMat, cannyMat, mask, new Point(0.0, 0.0), 5);

    /*
     * DisplayMetrics displayMetrics = new DisplayMetrics();
     * getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
     * 
     * int height = displayMetrics.heightPixels; int width =
     * displayMetrics.widthPixels;
     */

    // System.out.println(p);
    // System.out.println(width);
    // Point p = new Point(mRgbMat.width() / 2, mRgbMat.height() / 2);
    Point seedPoint = new Point(p.x /* * (mRgbMat.width() / width) */, p.y /* * (mRgbMat.height() / height) */);

    Imgproc.resize(cannyMat, cannyMat, new Size(cannyMat.width() + 2.0, cannyMat.height() + 2.0));
    Imgproc.medianBlur(mRgbMat, mRgbMat, 15);
    int floodFillFlag = 8;

    int chosenColor = Color.parseColor(c);

    Imgproc.floodFill(mRgbMat, cannyMat, seedPoint,
        new Scalar(Color.red(chosenColor), Color.green(chosenColor), Color.blue(chosenColor)),
        new org.opencv.core.Rect(), new Scalar(5.0, 5.0, 5.0), new Scalar(5.0, 5.0, 5.0), floodFillFlag);

    Imgproc.dilate(mRgbMat, mRgbMat, mask, new Point(0.0, 0.0), 5);

    Mat rgbHsvImage = new Mat();
    Imgproc.cvtColor(mRgbMat, rgbHsvImage, Imgproc.COLOR_RGB2HSV);
    ArrayList<Mat> list1 = new ArrayList<Mat>(3);
    Core.split(rgbHsvImage, list1);

    Mat result = new Mat();

    List<Mat> listMat1 = new ArrayList<Mat>();
    listMat1.add(list1.get(0));
    listMat1.add(list1.get(1));
    listMat1.add(list.get(2));
    // Arrays.asList(list1.get(0), list1.get(1), list.get(2));
    Core.merge(listMat1, result);

    // Imgproc.circle(result, seedPoint, 10, new Scalar(0, 255, 0, 150), 4);

    Imgproc.cvtColor(result, result, Imgproc.COLOR_HSV2RGB);
    Core.addWeighted(result, 0.7, img, 0.3, 0.0, result);

    Bitmap resultBitmap = Bitmap.createBitmap(result.cols(), result.rows(), Bitmap.Config.ARGB_8888);
    Utils.matToBitmap(result, resultBitmap);
    // BitmapHelper.showBitmap(this, resultBitmap, detectEdgesImageView);
    return resultBitmap;
  }

  public static byte[] YUVtoNV21(List<byte[]> planes, int[] strides, int width, int height) {
    Rect crop = new Rect(0, 0, width, height);
    int format = ImageFormat.YUV_420_888;
    byte[] data = new byte[width * height * ImageFormat.getBitsPerPixel(format) / 8];
    byte[] rowData = new byte[strides[0]];
    int channelOffset = 0;
    int outputStride = 1;
    for (int i = 0; i < planes.size(); i++) {
      switch (i) {
        case 0:
          channelOffset = 0;
          outputStride = 1;
          break;
        case 1:
          channelOffset = width * height + 1;
          outputStride = 2;
          break;
        case 2:
          channelOffset = width * height;
          outputStride = 2;
          break;
      }

      ByteBuffer buffer = ByteBuffer.wrap(planes.get(i));
      int rowStride;
      int pixelStride;
      if (i == 0) {
        rowStride = strides[i];
        pixelStride = strides[i + 1];
      } else {
        rowStride = strides[i * 2];
        pixelStride = strides[i * 2 + 1];
      }
      int shift = (i == 0) ? 0 : 1;
      int w = width >> shift;
      int h = height >> shift;
      buffer.position(rowStride * (crop.top >> shift) + pixelStride * (crop.left >> shift));
      for (int row = 0; row < h; row++) {
        int length;
        if (pixelStride == 1 && outputStride == 1) {
          length = w;
          buffer.get(data, channelOffset, length);
          channelOffset += length;
        } else {
          length = (w - 1) * pixelStride + 1;
          buffer.get(rowData, 0, length);
          for (int col = 0; col < w; col++) {
            data[channelOffset] = rowData[col * pixelStride];
            channelOffset += outputStride;
          }
        }
        if (row < h - 1) {
          buffer.position(buffer.position() + rowStride - length);
        }
      }
    }
    return data;

  }

  public static byte[] NV21toJPEG(byte[] nv21, int width, int height, int quality) {
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    YuvImage yuv = new YuvImage(nv21, ImageFormat.NV21, width, height, null);
    yuv.compressToJpeg(new Rect(0, 0, width, height), quality, out);
    return out.toByteArray();
  }

  private byte[] getBatteryLevel(List<byte[]> bytesList, int imageHeight, int imageWidth) {
    int rotation = 90;
    ByteBuffer Y = ByteBuffer.wrap(bytesList.get(0));
    ByteBuffer U = ByteBuffer.wrap(bytesList.get(1));
    ByteBuffer V = ByteBuffer.wrap(bytesList.get(2));

    int Yb = Y.remaining();
    int Ub = U.remaining();
    int Vb = V.remaining();

    byte[] data = new byte[Yb + Ub + Vb];

    Y.get(data, 0, Yb);
    V.get(data, Yb, Vb);
    U.get(data, Yb + Vb, Ub);

    Bitmap bitmapRaw = Bitmap.createBitmap(imageWidth, imageHeight, Bitmap.Config.ARGB_8888);
    Allocation bmData = renderScriptNV21ToRGBA888(this, imageWidth, imageHeight, data);
    bmData.copyTo(bitmapRaw);

    Matrix matrix = new Matrix();
    matrix.postRotate(rotation);
    Bitmap finalbitmapRaw = Bitmap.createBitmap(bitmapRaw, 0, 0, bitmapRaw.getWidth(), bitmapRaw.getHeight(), matrix,
        true);

    ByteArrayOutputStream stream = new ByteArrayOutputStream();
    finalbitmapRaw.compress(Bitmap.CompressFormat.PNG, 100, stream);
    byte[] byteArray = stream.toByteArray();
    finalbitmapRaw.recycle();

    return (byteArray);
  }

  public Allocation renderScriptNV21ToRGBA888(Context context, int width, int height, byte[] nv21) {
    RenderScript rs = RenderScript.create(context);
    ScriptIntrinsicYuvToRGB yuvToRgbIntrinsic = ScriptIntrinsicYuvToRGB.create(rs, Element.U8_4(rs));

    Type.Builder yuvType = new Type.Builder(rs, Element.U8(rs)).setX(nv21.length);
    Allocation in = Allocation.createTyped(rs, yuvType.create(), Allocation.USAGE_SCRIPT);

    Type.Builder rgbaType = new Type.Builder(rs, Element.RGBA_8888(rs)).setX(width).setY(height);
    Allocation out = Allocation.createTyped(rs, rgbaType.create(), Allocation.USAGE_SCRIPT);

    in.copyFrom(nv21);

    yuvToRgbIntrinsic.setInput(in);
    yuvToRgbIntrinsic.forEach(out);
    return out;
  }

  public void saveImage(Bitmap image) {
    MediaStore.Images.Media.insertImage(getContentResolver(), image, "Image", "description");
    /*
     * String root = Environment.getExternalStorageDirectory().getAbsolutePath();
     * File myDir = new File(root + "/paintApp"); myDir.mkdirs();
     * 
     * String fname = "Image" + ".jpg"; File file = new File(myDir, fname); if
     * (file.exists()) file.delete(); try { FileOutputStream out = new
     * FileOutputStream(file); image.compress(Bitmap.CompressFormat.JPEG, 90, out);
     * out.flush(); out.close();
     * 
     * } catch (Exception e) { e.printStackTrace(); }
     */
  }
}
